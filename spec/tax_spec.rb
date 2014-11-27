require_relative "../lib/tax.rb"
require_relative "../lib/product.rb"

describe Tax do
  let(:tax_class) { Tax.new } 
  
  describe "#calculate_tax" do
    context "when product is exempt from taxes" do
      let(:product) { Product.new({name: 'book 1', price: 10, categories: ['book', 'some other cat']}) }

      it "returns 0" do
        tax = tax_class.calculate_tax product
        expect(tax).to eq 0
      end
    end

    context "when product is imported" do
      let(:product) { Product.new({name: 'book 1', price: 10, categories: ['imported', 'goods']}) }

      it "returns >= 5" do
        tax = tax_class.calculate_tax product
        expect(tax).to be > 6
      end
    end
  end
end