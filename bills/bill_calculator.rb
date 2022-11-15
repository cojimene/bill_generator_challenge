class BillCalculator
  BASIC_SALES_TAX = 0.1
  IMPORT_DUTY = 0.05

  attr_reader :products, :bill

  def initialize(products)
    @products = products
    @bill = []
    # support/food.txt is a short dictionary for words to check if the product contains in its name a food
    # the dictionary should be increased of find another method to make this evaluation
    @food_list = File.readlines('support/food.txt').map(&:strip)
    @before_taxes = 0
    @total = 0
  end

  def create_bill
    calculate_taxes
    fill_with_products
    fill_with_totals
  end

  private

  def calculate_taxes
    @products.map do |product|
      taxes = tax_free?(product[:name]) ? 0 : BASIC_SALES_TAX
      taxes += IMPORT_DUTY if product[:imported]
      product[:taxes] = (product[:price] * taxes * 20).ceil / 20.0
    end
  end

  def tax_free?(product_name)
    product_name.split(' ').any? do |word|
      @food_list.include?(word) || %w[book pills].include?(word)
    end
  end

  def fill_with_products
    @products.each do |product|
      @before_taxes += product[:price] * product[:quantity]
      sub_total = (product[:price] + product[:taxes]) * product[:quantity]
      @total += sub_total
      imported = 'imported ' if product[:imported]
      @bill << "#{product[:quantity]} #{imported}#{product[:name]}: #{format(sub_total)}"
    end
  end

  def fill_with_totals
    @bill << "Sales Taxes: #{format(@total - @before_taxes)}"
    @bill << "Total: #{format(@total)}"
  end

  def format(amount)
    "%.2f" % amount
  end
end
