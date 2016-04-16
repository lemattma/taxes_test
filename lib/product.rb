class Product
  attr_accessor :attributes

  # Private: Initialize some values
  #          :tax default to 0
  #          :price converted to float
  #
  def initialize(attributes)
    @attributes = attributes
    @attributes[:tax] = 0
    @attributes[:price] = @attributes[:price].to_f
  end
end
