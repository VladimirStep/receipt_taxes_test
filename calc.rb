#! /usr/bin/env ruby

require 'csv'
require_relative 'lib/data_parser'

include DataParser

input = []
ARGF.each_line do |line|
  input << CSV.parse_line(line)
end

receipt = parse_receipt(input)

receipt.save_csv
puts receipt.to_std_out
