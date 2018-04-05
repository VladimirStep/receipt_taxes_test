class Receipt
  def initialize(receipt_items)
    @receipt_items = receipt_items
    perform_calculations
  end

  def calculate_sales_taxes
    @sales_taxes = @receipt_items.map { |item| item.tax_value }.inject(&:+).round(2)
  end

  def calculate_total
    @total = @receipt_items.map { |item| item.total_price }.inject(&:+).round(2)
  end

  def perform_calculations
    calculate_sales_taxes
    calculate_total
  end

  def to_std_out
    puts @receipt_items.map { |item| item.string_format }
    puts "Sales Taxes: #{'%.2f' % @sales_taxes}"
    puts "Total: #{'%.2f' % @total}"
  end

  def to_csv
    CSV.generate do |csv|
      @receipt_items.each do |item|
        csv << item.array_format
      end
      csv << ["Sales Taxes: #{'%.2f' % @sales_taxes}"]
      csv << ["Total: #{'%.2f' % @total}"]
    end
  end

  def save_csv
    File.open(file_path, 'w') do |f|
      f.write(self.to_csv)
    end
  end

  def generate_filename
    "#{Time.now.to_i}.csv"
  end

  def file_path
    "./output/#{generate_filename}"
  end
end