class Receipt
  def initialize(receipt_items)
    @receipt_items = receipt_items
  end

  def calculate_sales_taxes
    @receipt_items.map { |item| item.tax_value }.inject(&:+)
  end

  def calculate_total
    @receipt_items.map { |item| item.total_price }.inject(&:+)
  end
end