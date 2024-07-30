require 'rails_helper'

RSpec.describe "Merchant Dashboard", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Seymore")
    @merchant_2 = create(:merchant, name: "Audrey")

    @item_1 = create(:item, name: "singlet", merchant: @merchant_1)
    @item_2 = create(:item, name: "boots", merchant: @merchant_1)
    @item_3 = create(:item, name: "belt", merchant: @merchant_1)
    @item_4 = create(:item, name: "chair", merchant: @merchant_2)
  end

  # User Story 6
  describe "As a merchant" do
    # DO I NEED A WITHIN HERE?
    it "shows a list of the names of all my items" do
      # As a merchant,
      # When I visit my merchant items index page (merchants/:merchant_id/items)
      visit merchant_items_path(@merchant_1)

      within "#merchant_items" do
        # I see a list of the names of all of my items
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)
        
        # And I do not see items for any other merchant
        expect(page).to_not have_content(@item_4.name)
      end
    end
  end
end