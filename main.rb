#!/usr/bin/env ruby2.0

require './proc_work.rb'
require './proc.rb'
require 'narray'
require 'pp'


$data_name = ARGV[0]
$noise_name = ARGV[1]
$noise_cycle = 5
$eps = 0.001


Proc_main.main