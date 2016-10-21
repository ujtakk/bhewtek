// Node.js
"use strict";

////////////////////////////////////////////////////////////
// initialize
////////////////////////////////////////////////////////////

var fs = require("fs");
fs.mkdir("result", function(err) {});

require("date-utils");
var date = new Date();
var path = require("path");
var log = path.join("result", date.toFormat("YYMMDD-HHMISS")+".log");

var serialPort  = require("serialport");

var globalSetting = {
  baudRate: 115200,
  databits: 8,
  parity: "none",
  stopBits: 1,
  flowControl: false,
  parser: serialPort.parsers.readline("\n"),
};

var systemPort, meterPort;
var spSystem, spMeter;

var system  = "system:";
var meter   = "meter:";

////////////////////////////////////////////////////////////
// start processing
////////////////////////////////////////////////////////////

serialPort.list(function(err, ports) {

  ports.forEach(function(port) {
    if (/Cypress/.test(port.manufacturer))
      systemPort = port.comName;
    if (/Arduino/.test(port.manufacturer))
      meterPort = port.comName;
  });

  spSystem  = new serialPort(systemPort, globalSetting);
  spMeter   = new serialPort(meterPort, Object.assign({}, globalSetting, {autoOpen: false}));

  ////////////////////////////////////////////////////////////
  // spMeter
  ////////////////////////////////////////////////////////////

  spSystem.on("data", function(input) {
    var result = input.toString();

    if (/BEGIN/.test(result)) {
      // console.log(system, result);
      spMeter.open();
    }
    else if (/END/.test(result)) {
      // console.log(system, result);
      spMeter.close();
    }
    else {
      // console.log(system, result);
    }
  });

  spSystem.on("open", function(err) {
    console.log(system, "port opened.");
  });

  spSystem.on("close", function(err) {
    console.log(system, "port closed.");
  });

  ////////////////////////////////////////////////////////////
  // spMeter
  ////////////////////////////////////////////////////////////

  spMeter.on("data", function(input) {
    var result = input.toString();
    console.log(result);
    fs.appendFile(log, result+"\n");
  });

  spMeter.on("open", function(err) {
    console.log(meter, "port opened.");
  });

  spMeter.on("close", function(err) {
    console.log(meter, "port closed.");
  });
});
