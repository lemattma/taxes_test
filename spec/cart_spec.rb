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
end