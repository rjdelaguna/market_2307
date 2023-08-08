class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.keys.include?(item) }
  end

  def sorted_item_list
    @vendors.each_with_object([]) do |vendor, array|
      array << vendor.items_by_name
    end.flatten.uniq.sort
  end

  
  def total_inventory
    all_items.each_with_object({}) do |item, hash|
     hash[item] = {quantity: item_stock.find { |each| each[0] == item }[1],
                   vendors: @vendors.find_all { |vendor| vendor.items.include?(item) }
                  }
    end
  end

  def overstocked_items
    item_stock.each_with_object([]) do |item, array|
      if item[1] > 50 && vendors_that_sell(item[0]).count > 1
        array << item[0]
      end
    end
  end

  private

  def all_items
    @vendors.map { |vendor| vendor.items }.flatten.uniq
  end

  def item_stock
    stocks = @vendors.map { |vendor| vendor.inventory }
    total = Hash.new(0)
    stocks.map do |stock|
      stock.each do |item|
        total[item[0]] += item[1]
      end
    end
    total
  end
end