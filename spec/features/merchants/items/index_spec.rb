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

  # User Story #11
  describe "creating new item from merchant index page" do
    it "creates new merchant item via form" do
      @merchant_1 = create(:merchant, name: "Tarzhay")

      # As a merchant
      # When I visit my items index page
      visit merchant_items_path(@merchant_1)

      # I see a link to create a new item.
      expect(page).to have_link("Create New Item", new_merchant_item(@merchant_1))

      # When I click on the link,
      click_link "Create New Item"
      expect(current_path).to eq(new_merchant_item(@merchant_1))

      # I am taken to a form that allows me to add item information.
      fill_in "Name: ", with: "Jinco Jeans"
      fill_in "Description: ", with "Thug Life"
      fill_in "Unit Price: ", with "1000"

      # When I fill out the form I click ‘Submit’
      click_button "Submit"

      # Then I am taken back to the items index page
      expect(current_path).to eq(merchant_items_path(@merchant_1))

      # And I see the item I just created displayed in the list of items.
      expect(page).to have_content("Jinco Jeans")
      expect(page).to have_content("Thug Life")
      expect(page).to have_content("1000")

      # And I see my item was created with a default status of disabled.
      expect(page).to have_content("Status: Disabled")
    end
  end
end