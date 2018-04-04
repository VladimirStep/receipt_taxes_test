module TaxRates
  DEFAULT_RATE = 10
  IMPORT_RATE = 5

  BOOKS = %w[book].freeze
  FOOD = %w[chocolate].freeze
  MEDICAL = %w[pill].freeze

  def get_tax_rate(name = nil)
    raise CalculationError.new 'Product name is empty or incorrect' unless name
    rate = 0
    rate += IMPORT_RATE if imported?(name)
    rate += DEFAULT_RATE unless tax_free?(name)
    rate
  end

  def calculate_tax_value(price = nil, rate = nil)
    raise CalculationError.new 'Price or tax rate not set' unless price && rate
    raise CalculationError.new 'Price or tax rate should be a Number' unless price.is_a?(Numeric) && rate.is_a?(Numeric)
    tax_round( ( price * rate ) / 100.0 )
  end

  def imported?(name)
    name.include?('imported')
  end

  def tax_free?(name)
    tax_free_list.any? { |product| name.include?(product) }
  end

  def tax_free_list
    BOOKS + FOOD + MEDICAL
  end

  def tax_round(number)
    ( (number * 20).round / 20.0 )
  end

  class CalculationError < StandardError; end
end