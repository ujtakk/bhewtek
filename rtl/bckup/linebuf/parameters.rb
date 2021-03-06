#!/usr/bin/env ruby

# ERB parameter
$project = '/home/work/takau/bhewtek'
$core = 8
$core_log = (Math.log($core)/Math.log(2)).to_i
$tech = nil # rohm
$conv_delay = 5;
$pool_delay = $conv_delay + 2;
$max_size = 32;

# Verilog parameter
$dwidth = 16
$in_hei = 28
$pm1hei = 12
$insize = 12
$fsize = 5
$psize = 2
$n_f1 = 20
$n_f2 = 50
$outsize = 10
$wsize = 13
$ifmsize = 9
$faccum = 7
$paccum = 8
$lwidth = 8
$step = 10

