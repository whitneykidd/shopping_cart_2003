require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start
require './lib/product'
require './lib/shopping_cart'


RSpec.configure do |config|
  config.default_formatter = 'doc'
end

RSpec.describe 'Shopping Cart Spec Harness' do
  describe '1 Iteration' do
    before :each do
      @product = Product.new(:paper, 'toilet paper', 3.70, '10')
    end

    it '1. Product instantiation' do
      expect(Product).to respond_to(:new).with(4).argument
      expect(@product).to be_an_instance_of(Product)

      expect(@product).to respond_to(:category).with(0).argument
      expect(@product.category).to eq(:paper)

      expect(@product).to respond_to(:name).with(0).argument
      expect(@product.name).to eq('toilet paper')

      expect(@product).to respond_to(:unit_price).with(0).argument
      expect(@product.unit_price).to eq(3.70)

      expect(@product).to respond_to(:quantity).with(0).argument
      expect(@product.quantity).to eq(10)
    end

    it '2. Product #total_price' do
      expect(@product).to respond_to(:total_price).with(0).argument
      expect(@product.total_price).to eq(37.0)
    end

    it '3. Product #is_hoarded?' do
      expect(@product).to respond_to(:is_hoarded?).with(0).argument
      expect(@product.is_hoarded?).to eq(false)
    end

    it '4. Product #hoard' do
      expect(@product).to respond_to(:hoard).with(0).argument
      @product.hoard
      expect(@product.is_hoarded?).to eq(true)
    end
  end

  describe '2 Iteration' do
    before :each do
      @cart = ShoppingCart.new("King Soopers", "30items")
      @product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
      @product2 = Product.new(:meat, 'chicken', 4.50, '2')
    end

    it '5. ShoppingCart instantiation' do
      expect(ShoppingCart).to respond_to(:new).with(2).argument
      expect(@cart).to be_an_instance_of(ShoppingCart)

      expect(@cart).to respond_to(:name).with(0).argument
      expect(@cart.name).to eq("King Soopers")
    end

    it '6. ShoppingCart #capacity' do
      expect(@cart).to respond_to(:capacity).with(0).argument
      expect(@cart.capacity).to eq(30)
    end

    it '7. ShoppingCart #add_product' do
      expect(@cart).to respond_to(:add_product).with(1).argument
      @cart.add_product(@product1)
      @cart.add_product(@product2)
      expect(@cart.products).to eq([@product1, @product2])
    end
  end

  describe '3 Iteration' do
    before :each do
      @cart = ShoppingCart.new("King Soopers", "30items")
      @product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
      @product2 = Product.new(:meat, 'chicken', 4.50, '2')
      @product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
      @product4 = Product.new(:produce, 'apples', 0.99, '20')
      @cart.add_product(@product1)
      @cart.add_product(@product2)
      @cart.add_product(@product3)
    end

    it '8. ShoppingCart #total_number_of_products' do
      expect(@cart).to respond_to(:total_number_of_products).with(0).argument
      expect(@cart.total_number_of_products).to eq(13)

      @cart.add_product(@product4)

      expect(@cart.total_number_of_products).to eq(33)
    end

    it '9. ShoppingCart #is_full?' do
      expect(@cart).to respond_to(:is_full?).with(0).argument
      expect(@cart.is_full?).to eq(false)

      @cart.add_product(@product4)

      expect(@cart.is_full?).to eq(true)
    end

    it '10. ShoppingCart #products_by_category' do
      expect(@cart.products_by_category(:paper)).to eq([@product1, @product3])
      expect(@cart.products_by_category(:meat)).to eq([@product2])
    end

    it '11. ShoppingCart #details' do
      expect(@cart).to respond_to(:details).with(0).argument
      expect(@cart.details).to eq({name: 'King Soopers', capacity: 30})
    end
  end

  describe '4 Iteration' do
    before :each do
      @cart = ShoppingCart.new("King Soopers", "30items")
      @product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
      @product2 = Product.new(:meat, 'chicken', 4.50, '2')
      @product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
      @product4 = Product.new(:produce, 'apples', 0.99, '20')
      @cart.add_product(@product1)
      @cart.add_product(@product2)
      @cart.add_product(@product3)
    end

    it '12. ShoppingCart #percentage_occupied' do
      expect(@cart).to respond_to(:percentage_occupied).with(0).argument
      expect(@cart.percentage_occupied).to eq(43.33)
    end

    it '13. ShoppingCart #products_sorted_by_quantity' do
      expect(@cart).to respond_to(:sorted_products_by_quantity).with(0).argument

      @cart.add_product(@product4)

      expect(@cart.sorted_products_by_quantity).to eq([@product4, @product1, @product2, @product3])
    end

    it '14. ShoppingCart #product_breakdown' do
      expect(@cart).to respond_to(:product_breakdown).with(0).argument

      @cart.add_product(@product4)

      expected = {
        paper: [@product1, @product3],
        meat: [@product2],
        produce: [@product4]
      }

      expect(@cart.product_breakdown).to eq(expected)
    end
  end
end
