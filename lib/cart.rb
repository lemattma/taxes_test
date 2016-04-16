class Cart
  # Private: Initialize some values
  #          @cart_lines default to empty array
  #
  def initialize
    @cart_lines = []
  end

  # Public: Add a product to the cart
  #
  # data - Hash with quantity and product object
  #
  # Example
  #
  # add_product({qty: 3, product: #<Product object>})
  #
  # Returns false when invlaid quantity otherwise, returns cart_size
  def add_product(data)
    return false unless data[:qty] && data[:qty].to_i > 0

    @cart_lines << data

    cart_size
  end

  # Public: Apply taxes to cart products
  #
  # tax_class - Any tax class depending on local laws.
  #             Tax class should implement the methods #get_rules and #calculate_tax(product)
  #
  # Example
  #
  # apply_taxes(#<Tax object>})
  #
  # Returns nil
  def apply_taxes(tax_class)
    @cart_lines.each do |line|
      product = line[:product]
      tax_amount = tax_class.calculate_tax product
      product.attributes[:tax] = tax_amount
    end
  end

  # Public: Get final receipt
  #
  # Returns string with the final receipt including taxes
  def get_receipt
    str = ''
    total_taxes = 0.0
    total_price = 0.0

    @cart_lines.each do |line|
      product = line[:product]
      qty = line[:qty]

      # tax rounded to the nearest 0.05
      tax_cost = round_value(product.attributes[:price] * product.attributes[:tax] / 100)
      price = (qty * (product.attributes[:price] + tax_cost))

      total_price += price
      total_taxes += tax_cost

      str += "#{qty}, #{product.attributes[:name]}, %.2f\n" % [price]
    end

    str += "\nSales Taxes: %.2f\n" % [total_taxes]
    str += "Total: %.2f" % [total_price]
  end

  # Public: Get cart size
  #
  # Returns the cart items quantity
  def cart_size
    @cart_lines.size
  end

  private

  # Private: Round UP numbers to the nearest 0.05. We use the formule n*20.ceil / 20
  #
  # number - Numeric value
  #
  # Examples
  #
  # round_value(1.44)
  # #=> 1.45
  #
  # round_value(1.67)
  # #=> 1.70
  #
  # Returns rounded number
  def round_value(number)
    return false unless number.is_a? Numeric

    (number * 20).ceil / 20.0
  end
end
