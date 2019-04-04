class Cart
  def initialize(cart)
    @cart = cart
  end

  def total_count
    @cart.values.sum
  end
end
