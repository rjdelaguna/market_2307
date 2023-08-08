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
    all_items.map do |item|
      {item => {quantity: item_stock.find { |each| each[0] == item }[1],
                vendors: @vendors.find_all { |vendor| vendor.items.include?(item) }
               }
              }
    end[0]
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