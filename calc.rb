#! /usr/bin/env ruby

require 'csv'
require_relative 'data_parser'

include DataParser

input = []
ARGF.each_line do |line|
  input << CSV.parse_line(line)
end

receipt = parse_receipt(input)

puts receipt.inspect

