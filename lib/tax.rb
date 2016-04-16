class Tax
  # Public: Calculate tax % for one product
  #
  # product - #<Product object>
  #
  # Returns the % of calculated tax for the product
  def calculate_tax(product)
    @tax_total = 0
    @cats = product.attributes[:categories]
    process
  end

  private

  def process
    rules.each { |rule| process_rule(rule) }
    @tax_total
  end

  def process_rule(rule)
    [:all, :except].each do |rule_type|
      next unless rule_categories = rule[rule_type]

      categories_match = (rule_categories & @cats).size > 0

      if should_apply_tax?(rule_type, categories_match)
        add_tax_amount(rule[:amount])
      end
    end
  end

  def should_apply_tax?(rule_type, categories_match)
    # if type is :except, we have to reverse the match boolean result
    rule_type == :except ? !categories_match : categories_match
  end

  def add_tax_amount(amount)
    @tax_total += amount
  end

  def rules
    [
      { amount: 5, all: ['imported'] },
      { amount: 10, except: ['book', 'food', 'medical'] }
    ]
  end
end
