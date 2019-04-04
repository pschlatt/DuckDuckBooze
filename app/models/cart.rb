class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
    #@contents.default = 0
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
