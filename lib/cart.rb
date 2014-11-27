class Cart

  def initialize
    # cart_lines is a collection of lines
    # line item example
    # {qty: 3, product: #<Product object>}

    @cart_lines = []
  end

  def add_product data
    return false unless data[:qty] and data[:qty].to_i > 0

    @cart_lines << data

    cart_size
  end

  def cart_size
    @cart_lines.size
  end

  def apply_taxes tax_class
    @cart_lines.each do |line|
      product = line[:product]
      tax_amount = tax_class.calculate_tax product
      product.attributes[:tax] = tax_amount
    end
  end

  def print_receipt
    str = ''
    total_taxes = 0.0
    total_price = 0.0

    @cart_lines.each do |line|
      product = line[:product]
      qty     = line[:qty]

      # price = quantity * prod w/taxes
      tax_cost = round_tax (product.attributes[:price] * product.attributes[:tax] / 100)
      price = (qty * (product.attributes[:price] + tax_cost))

      
      total_price += price
      total_taxes += tax_cost

      str += "#{qty}, #{product.attributes[:name]}, %.2f\n" % [price]
    end

    str += "\nSales Taxes: %.2f\n" % [total_taxes]
    str += "Total: %.2f" % [total_price]

    str
  end

  def round_tax fl
    (fl * 20).ceil / 20.0
  end
end