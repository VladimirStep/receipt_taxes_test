require_relative 'tax_rates'

class Nomenclature
  include TaxRates

  attr_reader :name, :price_with_tax

  def initialize(name, price)
    @name = name
    @price = price
    calculate_tax
  end

  def calculate_tax
    tax_rate = get_tax_rate(@name)
    @price_with_tax = calculate_price_with_tax(@price, tax_rate)
  end
end