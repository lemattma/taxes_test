class Tax

  # Public: Returns hash with rules
  #
  def get_rules
    [
      {amount: 5, all: ['imported']},
      {amount: 10, except: ['book','food','medical']}
    ]
  end

  # Public: Calculate tax % for one product
  #
  # product - #<Product object>
  #
  # Returns the % of calculated tax for the product
  def calculate_tax(product)
    tax_total = 0

    get_rules.each do |rule|

      cats = product.attributes[:categories]

      # taxes for all the products
      if rule[:all]
        # size of the intersection array > 0
        all = (rule[:all] & cats).size > 0
        tax_total += rule[:amount] if all
      end

      # taxes with exceptions
      if rule[:except]
        # size of the intersection array > 0
        except = (rule[:except] & cats).size > 0
        tax_total += rule[:amount] unless except
      end
    end

    tax_total
  end
end
