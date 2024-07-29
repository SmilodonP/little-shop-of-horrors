require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Seymore")
    @merchant_2 = create(:merchant, name: "Audrey")

    @item_1 = create(:item, name: "singlet", merchant: @merchant_1)
    @item_2 = create(:item, name: "boots", merchant: @merchant_1)
    @item_3 = create(:item, name: "belt", merchant: @merchant_1)
    @item_4 = create(:item, name: "chair", merchant: @merchant_2)
  end

  describe "As a merchant" do
    it "shows a list of the names of all my items" do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to_not have_content(@item_4.name)
    end
  end

end