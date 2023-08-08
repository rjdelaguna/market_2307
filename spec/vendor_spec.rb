require 'spec_helper'

RSpec.describe Vendor do
  let (:vendor) {Vendor.new("Rocky Mountain Fresh")}
  let (:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let (:vendor3) {Vendor.new("Palisade Peach Shack")}

  let (:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let (:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let (:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let (:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  describe "#initialize" do
    it 'exists and has readable attributes' do

      expect(vendor).to be_a Vendor
      expect(vendor.name).to eq("Rocky Mountain Fresh")
    end
  end

  describe "#inventory" do
    it 'begins as an empty hash' do

      expect(vendor.inventory).to eq({})
    end
  end

  describe "#check_stock" do
    it 'returns the count of passed in item, or zero if none' do

      expect(vendor.check_stock(item1)).to eq(0)
    end
  end

  describe "#stock" do
    it 'adds amount of passed in item to the inventory hash' do
      vendor.stock(item1, 30)
      
      expect(vendor.inventory).to eq({item1 => 30})
      expect(vendor.check_stock(item1)).to eq(30)
      
      vendor.stock(item1, 25)
      vendor.stock(item2, 12)
      
      expect(vendor.check_stock(item1)).to eq(55)
      expect(vendor.inventory).to eq({item1 => 55, item2 => 12})
    end
  end

  describe "#items" do
    it 'returns an array of all item objects' do
      vendor.stock(item1, 30)
      vendor.stock(item2, 12)

      expect(vendor.items).to eq([item1, item2])
    end
  end
  
  describe "#items_by_name" do
    it 'returns an array of the names of each item in inventory' do
      vendor.stock(item1, 30)
      vendor.stock(item2, 12)

      expect(vendor.items_by_name).to eq(["Peach", "Tomato"])
    end
  end

  describe "#potential_revenue" do
    it 'returns the value of current inventory' do
      vendor.stock(item1, 35)
      vendor.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      expect(vendor.potential_revenue).to eq(29.75)
      expect(vendor2.potential_revenue).to eq(345.00)
      expect(vendor3.potential_revenue).to eq(48.75)
    end
  end
end



