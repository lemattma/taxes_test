class Cart

  def initialize
    # cart_lines is a collection of lines
    # line item example
    # {qty: 3, product: #<Product object>}

    @cart_lines = []
  end

  def add_product(data)
    return false unless data[:qty] and data[:qty].to_i > 0

    @cart_lines << data

    cart_size
  end

  def apply_taxes(tax_class)
    @cart_lines.each do |line|
      product = line[:product]
      tax_amount = tax_class.calculate_tax product
      product.attributes[:tax] = tax_amount
    end
  end

  def get_receipt
    #init values
    str, total_taxes, total_price = '', 0.0, 0.0

    @cart_lines.each do |line|
      product = line[:product]
      qty     = line[:qty]

      # tax rounded to the nearest 0.05
      tax_cost = round_value (product.attributes[:price] * product.attributes[:tax] / 100)
      price = (qty * (product.attributes[:price] + tax_cost))

      total_price += price
      total_taxes += tax_cost

      str += "#{qty}, #{product.attributes[:name]}, %.2f\n" % [price]
    end

    str += "\nSales Taxes: %.2f\n" % [total_taxes]
    str += "Total: %.2f" % [total_price]
  end

  def cart_size
    @cart_lines.size
  end

  private

  def round_value(number)
    return false unless number.is_a? Numeric

    (number * 20).ceil / 20.0
  end
end