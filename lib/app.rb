require_relative "cart.rb"
require_relative "product.rb"
require_relative "tax.rb"

class App
  def process(input)
    # Input example
    #
    # Quantity, Product, Price
    # 1, imported bottle of perfume, 27.99
    # 1, bottle of perfume, 18.99
    #
    return "Error: invalid input" if input.each_line.count < 2

    # explode input in lines removing extra \s
    lines = input.each_line.map &:strip
    # Remove first line with input fields
    lines.shift

    # initialize the cart
    cart = Cart.new

    lines.each do |line|
      # explode line data removing extra \s
      line_array = line.split(',').map &:strip

      # get the quantity from the first column of the input
      qty = line_array.shift.to_i

      # contruct labeled data for the product
      data = Hash[[:name, :price, :categories].zip line_array]
      data[:categories] = data[:categories] ? data[:categories].split('|') : ['general good']

      # add the product to the cart
      product = Product.new data
      cart.add_product({qty: qty, product: product})
    end
  
    # Let's apply taxes
    tax_class = Tax.new
    cart.apply_taxes tax_class

    cart.get_receipt
  end
end

