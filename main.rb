#!/usr/bin/env ruby2.0

require './proc_work.rb'
require './proc.rb'
require './tools.rb'
require './compress.rb'
require 'pathname'
require 'narray'
require 'pp'
require 'ai4r'


$data_name = ARGV[0]
$noise_name = ARGV[1]

$NOISE_CYCLE = 5
$EPS = 0.001
$SAMPLE_SIZE = 0
$SAMPLE_PERIOD = 1
$DATA_COMPRESS = 10

timemarks = Timemarks.new($data_name)
mf_data = timemarks.get_membership_function()
Tools.data_print2(mf_data.keys, mf_data.values, 'mf_data')
exit


data_time, data_proc = Proc_main.main

compress = Signal_compress.new(data_proc)
data_comp = compress.comp($DATA_COMPRESS)

compress = Signal_compress.new(data_time)
data_time_comp = compress.comp($DATA_COMPRESS)

Tools.data_print2(data_time_comp, data_comp, "#{Pathname.new($data_name).basename}_clear_comp#{$DATA_COMPRESS}")

# Tools.data_print(data_proc, "t_01_clear")
# Tools.data_print(compress.comp(2), "t_01_comp_2")
# Tools.data_print(compress.comp(5), "t_01_comp_5")
# Tools.data_print(compress.comp(10), "t_01_comp_10")
# Tools.data_print(compress.comp(20), "t_01_comp_20")
# Tools.data_print(compress.comp(40), "t_01_comp_40")
# Tools.data_print(compress.comp(80), "t_01_comp_80")