require './bills/bill_importer'
require './bills/bill_calculator'

bill_importer = BillImporter.new
bill_importer.check_products
bill_calculator = BillCalculator.new(bill_importer.products)
bill_calculator.create_bill
puts bill_calculator.bill