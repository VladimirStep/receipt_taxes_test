require_relative 'nomenclature'

class ReceiptItem
  attr_reader :quantity, :name, :tax_value, :total_price

  def initialize(quantity, name, price)
    @quantity = quantity
    @nomenclature = Nomenclature.new(name, price)
    get_name
    get_tax_value
    calculate_total_price
  end

  def get_name
    @name = @nomenclature.name
  end

  def get_tax_value
    @tax_value = @nomenclature.tax_value
  end

  def calculate_total_price
    @total_price = ( @quantity * @nomenclature.price_with_tax ).round(2)
  end
end