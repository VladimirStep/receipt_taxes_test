require_relative 'tax_rates'

class Nomenclature
  include TaxRates

  attr_reader :name, :tax_value, :price_with_tax

  def initialize(name, price)
    @name = name
    @price = price
    calculate_tax
  end

  def calculate_tax
    tax_rate = get_tax_rate(@name)
    @tax_value = calculate_tax_value(@price, tax_rate)
    @price_with_tax = ( @price + @tax_value ).round(2)
  end
end