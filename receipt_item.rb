require_relative 'nomenclature'

class ReceiptItem
  def initialize(quantity, name, price)
    @quantity = quantity
    @nomenclature = Nomenclature.new(name, price)
    calculate_total_price
  end

  def calculate_total_price
    @total_price = ( @quantity * @nomenclature.price_with_tax ).round(2)
  end
end