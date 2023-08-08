require 'spec_helper'

RSpec.describe Market do
  let (:market) {Market.new("South Pearl Street Farmers Market")}
  let (:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let (:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let (:vendor3) {Vendor.new("Palisade Peach Shack")}

  let (:item1) {Item.new({name: "Peach", price: "$0.75"})}
  let (:item2) {Item.new({name: "Tomato", price: "$0.50"})}
  let (:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let (:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  before(:each) do
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)
  end

  describe "#initialize" do
    it 'exists and has readable attributes' do

      expect(market).to be_a Market
      expect(market.name).to eq("South Pearl Street Farmers Market")
    end
  end

  describe "#vendors" do
    it 'begins as an empty array' do

      expect(market.vendors).to eq([])
    end
  end

  context "after vendors have been added" do
    before(:each) do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
    end
  
    describe "#add_vendor" do
      it 'adds new vendor to vendors array' do

        expect(market.vendors).to eq([vendor1,vendor2, vendor3])
      end
    end

    describe "#vendor_names" do
      it 'returns an array of all vendor names' do

        expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
      end
    end

    describe "#vendors_that_sell" do
      it 'returns an array of all venodors that have passed in item in stock' do

        expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
        expect(market.vendors_that_sell(item4)).to eq([vendor2])
      end
    end

    describe "#sorted_item_list" do
      it 'returns an array of all item names vendors have in stock, alphabetically, no duplicates' do

        expect(market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
      end
    end

    describe "#total_inventory" do
      it 'returns hash of all items, their inventory, and vendors who sell it' do
        expectation = {item1 => {quantity: 100, vendors: [vendor1, vendor3]}, item2 => {quantity: 7, vendors: [vendor1]}, item3 => {quantity: 25, vendors: vendor2}, item4 => {quantity: 50, vendors: [vendor2]}}

        expect(market.total_inventory).to eq(expectation)
      end
    end

    describe "#overstocked_items" do
      xit 'returns an array of items sold by more than one vendor and a quantity over 50' do

        expect(market.overstocked_items).to eq([item1])
      end
    end
  end
end







