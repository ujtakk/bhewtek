var serialPort = require('serialport');

var globalSetting = {
  baudRate: 115200,
  databits: 8,
  parity: "none",
  stopBits: 1,
  flowControl: false,
  parser: serialPort.parsers.readline("\n"),
};

var sp = new serialPort("/dev/ttyACM1", globalSetting);

sp.on("data", function(input) {
  var result = input.toString();
  console.log("hoge", result);
  // fs.appendFile(log, result+"\n");
});

sp.on("open", function(err) {
  console.log("hoge", "port opened.");
});

sp.on("close", function(err) {
  console.log("hoge", "port closed.");
});
