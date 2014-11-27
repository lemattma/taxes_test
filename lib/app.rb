require_relative "cart.rb"
require_relative "product.rb"
require_relative "tax.rb"

class App

  # Public: Process the product list input
  #
  # input - List of products
  #
  # Input example
  #
  # Quantity, Product, Price, Categories
  # 1, imported bottle of perfume, 27.99, imported
  # 1, bottle of perfume, 18.99
  #
  # Returns the list of products with taxes incl.
  def process(input)
    
    # return error message if there's less than 2 lines in the input
    # Considering the first one the columns names
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

