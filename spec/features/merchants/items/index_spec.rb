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

  # User Story 9
  describe "enabling & disabling items from merchant_items index page" do
    it "updates merchant_item status to 'Enabled' with button" do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, status: 0)
      # As a merchant
      # When I visit my items index page (/merchants/:merchant_id/items)
      visit merchant_items_path(@merchant_1)

      # Next to each item name I see a button to disable or enable that item.
      expect(page).to have_button("Enable")     
      expect(page).to have_button("Disable")

      # When I click this button
      click_button "Enable"

      # Then I am redirected back to the items index
      expect(current_path).to eq(merchant_items(@merchant_1))
      @item_1.reload

      # And I see that the items status has changed
      expect(@item_1.status).to eq("enabled")
    end

    it "updates merchant_item status to 'Disabled' with button" do
      @merchant_2 = create(:merchant)
      @item_2 = create(:item, status: 1)
      
      # As a merchant
      # When I visit my items index page (/merchants/:merchant_id/items)
      visit merchant_items_path(@merchant_2)

      # Next to each item name I see a button to disable or enable that item.
      expect(page).to have_button("Enable")     
      expect(page).to have_button("Disable")

      # When I click this button
      click_button "Disable"

      # Then I am redirected back to the items index
      expect(current_path).to eq(merchant_items(@merchant_2))
      @item_2.reload

      # And I see that the items status has changed
      expect(@item_2.status).to eq("disabled")
    end
  end

  # User Story #10
  describe "group merchant items by status" do
    it "displays enabled merchant items" do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, status: 0)
      @item_2 = create(:item, status: 0)
      @item_3 = create(:item, status: 1)
      @item_4 = create(:item, status: 1)

      # When I visit my merchant items index page
      visit merchant_items_path(@merchant_1)

      # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
      within '.enabled' do 
        expect(page).to have_content("Enabled Merchant Items")
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end

      # And I see that each Item is listed in the appropriate section
      within '.disabled' do 
        expect(page).to have_content("Disabled Merchant Items")
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_4.name)
      end
    end
  end
end