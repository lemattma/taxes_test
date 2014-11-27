class Tax
  RULES = [
    {amount: 5, all: ['imported']},
    {amount: 10, except: ['book','food','medical']}
  ]

  def get_rules
    RULES
  end

  def calculate_tax(product)
    tax_total = 0

    get_rules.each do |rule|

      cats = product.attributes[:categories]

      # taxes for all the products
      if rule[:all]
        all = (rule[:all] & cats).size > 0
        tax_total += rule[:amount] if all
      end

      # taxes with exceptions
      if rule[:except]
        except = (rule[:except] & cats).size > 0
        tax_total += rule[:amount] unless except
      end
    end

    tax_total
  end
end
