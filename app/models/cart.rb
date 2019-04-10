class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
    @contents.default = 0
  end

  def self.item_name(id)
    Item.find(id).name
  end

  def self.merchant_name(id)
    User.find(Item.find(id).user_id).name
  end

  def self.price(id)
    Item.find(id).item_price
  end

  def self.subtotal(id1, id2)
    (Item.find(id1).item_price * id2)
  end

  def self.grand_total(id1, id2)
    (Item.find(id1).item_price * id2)
  end

  def total_count
    @contents.values.sum
  end

  def add_item(id)
    @contents[id.to_s] += 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end
end
