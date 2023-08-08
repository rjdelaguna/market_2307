class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, add)
    @inventory[item] += add
  end

  def potential_revenue
    @inventory.sum { |item, amount| item.price * amount }
  end

  def items_by_name
    @inventory.map { |item, amount| item.name }
  end

  def items
    @inventory.map { |item, amount| item }
  end
end