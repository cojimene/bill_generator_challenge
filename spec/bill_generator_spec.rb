require './bills/bill_importer'
require './bills/bill_calculator'

describe 'Bill Generator' do
  subject do
    bill_importer.check_products
    bill_calculator = BillCalculator.new(bill_importer.products)
    bill_calculator.create_bill.join("\n")
  end

  let(:bill_importer) { BillImporter.new }

  let(:input1) do
    <<~INPUT
      2 book at 12.49
      1 music CD at 14.99
      1 chocolate bar at 0.85
    INPUT
  end

  let(:input2) do
    <<~INPUT
      1 imported box of chocolates at 10.00
      1 imported bottle of perfume at 47.50
    INPUT
  end

  let(:input3) do
    <<~INPUT
      1 imported bottle of perfume at 27.99
      1 bottle of perfume at 18.99
      1 packet of headache pills at 9.75
      3 imported box of chocolates at 11.25
    INPUT
  end

  let(:output1) do
    <<~OUTPUT
      2 book: 24.98
      1 music CD: 16.49
      1 chocolate bar: 0.85
      Sales Taxes: 1.50
      Total: 42.32
    OUTPUT
  end

  let(:output2) do
    <<~OUTPUT
      1 imported box of chocolates: 10.50
      1 imported bottle of perfume: 54.65
      Sales Taxes: 7.65
      Total: 65.15
    OUTPUT
  end

  let(:output3) do
    <<~OUTPUT
      1 imported bottle of perfume: 32.19
      1 bottle of perfume: 20.89
      1 packet of headache pills: 9.75
      3 imported box of chocolates: 35.55
      Sales Taxes: 7.90
      Total: 98.38
    OUTPUT
  end

  context 'when input comes as a bulk string' do
    before { allow($stdout).to receive(:write) }

    it 'obtains corresponding bill for input1' do
      allow(bill_importer).to receive(:gets).and_return(input1, "end\n")
      is_expected.to eq(output1.strip)
    end

    it 'obtains corresponding bill for input2' do
      allow(bill_importer).to receive(:gets).and_return(input2, "end\n")
      is_expected.to eq(output2.strip)
    end

    it 'obtains corresponding bill for input3' do
      allow(bill_importer).to receive(:gets).and_return(input3, "end\n")
      is_expected.to eq(output3.strip)
    end
  end

  context 'when input comes line by line' do
    before { allow($stdout).to receive(:write) }

    it 'obtains corresponding bill for input1' do
      allow(bill_importer).to receive(:gets).and_return(*input1.split("\n"), "end\n")
      is_expected.to eq(output1.strip)
    end

    it 'obtains corresponding bill for input2' do
      allow(bill_importer).to receive(:gets).and_return(*input2.split("\n"), "end\n")
      is_expected.to eq(output2.strip)
    end

    it 'obtains corresponding bill for input3' do
      allow(bill_importer).to receive(:gets).and_return(*input3.split("\n"), "end\n")
      is_expected.to eq(output3.strip)
    end
  end
end