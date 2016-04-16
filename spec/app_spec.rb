require_relative "../lib/app.rb"

describe App do
  let(:app) { App.new }
  let(:invalid_io) do
    {
      input: 'Quantity, Product, Price, Categories',
      output: 'Error: invalid input'
    }
  end

  let(:valid_io) do
    {
      input:  "Quantity, Product, Price, Categories\n"\
              "1, imported bottle of perfume, 27.99, imported\n"\
              "1, bottle of perfume, 18.99\n"\
              "1, packet of headache pills, 9.75, medical\n"\
              "1, box of imported chocolates, 11.25, imported|food",
      output: "1, imported bottle of perfume, 32.19\n"\
              "1, bottle of perfume, 20.89\n"\
              "1, packet of headache pills, 9.75\n"\
              "1, box of imported chocolates, 11.85\n\n"\
              "Sales Taxes: 6.70\n"\
              "Total: 74.68"
    }
  end

  describe "#process" do
    context "when invalid input" do
      it "return error message" do
        receipt = app.process invalid_io[:input]
        expect(receipt).to eq invalid_io[:output]
      end
    end
    context "when valid input" do
      it "processes prices adding taxes" do
        receipt = app.process valid_io[:input]
        expect(receipt).to eq valid_io[:output]
      end
    end
  end
end