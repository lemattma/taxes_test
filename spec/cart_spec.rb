require_relative "../lib/cart.rb"
require_relative "../lib/product.rb"
require_relative "../lib/tax.rb"

describe Cart do
  let(:cart) { Cart.new }
  let(:product) { Product.new({name: 'book1', price: 10, categories: ['book']}) } 
  
  describe "#add_product" do
    context "when invalid quantity" do
      it "returns false" do
        resp = cart.add_product({qty: 'a', product: product})
        expect(resp).to be false
      end
    end

    context "when valid quantity" do
      it "returns nil" do
        resp = cart.add_product({qty: 2, product: product})
        expect(resp).to be > 0
      end
    end
  end

  describe "#round_value" do
    context "invalid input" do
      it "returns false" do
        value = cart.round_value 'not numeric'
        expect(value).to be false
      end
    end

    context "valid input" do
      it "returns new rounded value" do
        value = cart.round_value 1.44
        expect(value).to be 1.45
      end
    end
  end
end