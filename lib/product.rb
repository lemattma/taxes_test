class Product
  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes
    @attributes[:tax] = 0
    @attributes[:price] = @attributes[:price].to_f
  end
end
