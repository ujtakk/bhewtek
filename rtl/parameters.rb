#!/usr/bin/env ruby

### ERB(Meta) parameter
$debug      = true
$project    = `pwd`.chomp.split('/rtl')[0]
$core       = 8   # Num of cores
$core_log   = (Math.log($core)/Math.log(2)).to_i
$tech       = nil # TODO: introduce mapping of specific devices.
$max_size   = 32  # Corresponds to acceptable max input size
$d_pixelbuf = 32  # Corresponds to acceptable max input size
$d_poolbuf  = 32  # Corresponds to acceptable max input size
$d_conv     = 5   # Delay clocks in the conv module
$d_accum    = 1   # Delay clocks in the accumlator module
$d_bias     = 2   # Delay clocks in the pool module
$d_relu     = 2   # Delay clocks in the pool module
$d_pool     = 2   # Delay clocks in the pool module

### Verilog parameter
# Hardware
$dwidth   = 16 # Data bitwidth
$lwidth   = 8  # Literal(Constant) data bitwidth
$step     = 10 # Step width(ns) per clock
$insize   = 12 # Address bitwidth of inputs: (12*12*20)
$outsize  = 12 # Address bitwidth of outputs: (12*12*20)
$wsize    = 12 # Address bitwidth of weights: (50*20*5*5)/8
$bsize    = 3  # Address bitwidth of weights: 50/8
$faccum   = 10 # Address bitwidth of conv fmap: (24*24)

# Network
$in_hei = 28
$n_f1   = 20
$n_f2   = 50
$fsize  = 5
$psize  = 2
$fm1hei = $in_hei - $fsize + 1
$pm1hei = $fm1hei / $psize
$fm2hei = $pm1hei - $fsize + 1
$pm2hei = $fm2hei / $psize

