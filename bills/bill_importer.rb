class BillImporter
  attr_reader :products

  def initialize
    @products = []
  end

  def check_products
    puts 'Insert your products with this format :quantity [:imported] :product_name at :price'
    puts "Finish with the word 'end' when you have done"

    get_the_products
  end

  private

  def get_the_products
    loop do
      input = gets.strip
      break if input == 'end'

      input.split("\n").each do |input_data|
        if matched_data = input_data.match(/(\d+) (imported )?([a-zA-Z ]+) at (\d+\.?\d*)/)
          @products << build_product(matched_data)
        else
          puts 'Please use the format :quantity [:imported] :product_name at :price'
        end
      end
    end
  end

  def build_product(matched_data)
    {
      quantity: matched_data[1].to_i,
      imported: !matched_data[2].nil?,
      name: matched_data[3],
      price: matched_data[4].to_f
    }
  end
end
