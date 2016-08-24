#!/usr/bin/env ruby

# ERB parameter
$project = `pwd`+'/bhewtek'
$core = 8
$core_log = (Math.log($core)/Math.log(2)).to_i
$tech = nil # rohm
$max_size = 32;
$d_convbuf = 0;#14;
$d_conv = 5;
$d_poolbuf = 0;#10;
$d_pool = 2;
#$d_pool = $d_conv + 3;

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

