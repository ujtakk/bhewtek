#!/usr/bin/env ruby

$old = false
# ERB parameter
$project = `pwd`.chomp.split('/rtl')[0]
$core = 8
$core_log = (Math.log($core)/Math.log(2)).to_i
$tech = nil # rohm
$max_size = 32
if $old
  $d_pixelbuf = 1
  $d_poolbuf  = 1
else
  $d_pixelbuf = 15
  $d_poolbuf  = 10
end
$d_conv = 5
$d_pool = 2
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

