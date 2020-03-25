class ShoppingCart
  attr_reader :name, :capacity, :products
  def initialize(name, capacity)
    @name = name
    @capacity = capacity.to_i
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def total_number_of_products
    @products.sum { |product| product.quantity }
  end

  def is_full?
    @capacity < total_number_of_products ? true : false
  end

  def products_by_category(category)
    products_in_category = []
    @products.each do |product|
      if product.category == category
        products_in_category << product
      end
    end
    products_in_category
  end

  def details
    cart_details = {:name => @name, :capacity => @capacity}
  end

  def percentage_occupied
    (( total_number_of_products.to_f / @capacity.to_f ) * 100).round(2)
  end

  def sorted_products_by_quantity
    ( @products.sort_by { |product| product.quantity }).reverse
  end

  def breakdown
    product_breakdown = {}
    @products.each do |product|
      if product_breakdown.keys.include?(product.category)
        product_breakdown[product.category] << product
      else
        product_breakdown[product.category] = [product]
      end
    end
    product_breakdown
  end
end
