class Prodct

  def initialize(category, name, unit_price, quantity)
    @category = category
    @name = name_parameter
    @unit_price = 3.70
    @quantity = quantity
  end

  def total_price
    @unit_price * @quantity
  end
end
