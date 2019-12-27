#!/usr/bin/env ruby
# encoding: UTF-8

$: << File.dirname(__FILE__)
$oj_dir = File.dirname(File.expand_path(File.dirname(__FILE__)))
%w(lib ext).each do |dir|
  $: << File.join($oj_dir, dir)
end

require 'oj'
require 'active_support'
require 'active_support/json'
#require 'tracer'

Oj::Rails.set_encoder()
Oj::Rails.set_decoder()
Oj::Rails.optimize()

#Oj::mimic_JSON

puts JSON.parse('{"a":1}', symbolize_names: true)
