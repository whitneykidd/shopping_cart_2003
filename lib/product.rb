class Product
  attr_reader :category, :name
  def initialize(category, name, unit_price, quantity)
    @category = category
    @name = name
    @unit_price = unit_price
    @quantity = quantity
  end

  def total_price
    @unit_price * @quantity
  end
end
