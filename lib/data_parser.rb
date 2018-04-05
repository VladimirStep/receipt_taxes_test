require_relative 'receipt_item'
require_relative 'receipt'

module DataParser
  HEADERS_STRUCTURE = %w[Quantity Product Price].freeze

  def parse_receipt(input_array = nil)
    raise DataParserError.new 'No data given' unless input_array
    normalized_array = normalize_input(input_array)
    check_and_remove_headers(normalized_array)
    receipt_items = parse_receipt_items(normalized_array)
    Receipt.new(receipt_items)
  end

  def normalize_input(input_array)
    input_array.each do |line|
      line.map! { |word| word.strip }
    end
  end

  def check_and_remove_headers(data)
    raise DataParserError.new "Data format is incorrect\nQuantity, Product, Price is expected" unless data[0] == HEADERS_STRUCTURE
    data.delete_at(0)
  end

  def parse_receipt_items(data_array)
    raise DataParserError.new 'No data given' if data_array.empty?
    receipt_items = []
    data_array.each do |item_data|
      receipt_items << parse_item(item_data)
    end
    receipt_items
  end

  def parse_item(data)
    quantity = data[0].to_i
    name = data[1]
    price = data[2].to_f
    ReceiptItem.new(quantity, name, price)
  end

  class DataParserError < StandardError; end
end