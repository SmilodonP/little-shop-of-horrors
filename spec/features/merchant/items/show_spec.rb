require "rails_helper"

RSpec.describe "Merchant Item Show Page", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Seymore")
    
    @item_1 = create(:item, name: "singlet", merchant: @merchant_1)
  end
  
  # User Story #8
  describe "editing merchant items" do
    it "links item name text to item show page" do
      # As a merchant,
      # When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
      visit merchant_items_path(@merchant_1)
      
      # REVISIT TO ADD WITHIN BLOCKS IF NECESSARY

        # I see a link to update the item information.
        expect(page).to have_link("#{@item_1.name}", href: edit_merchant_item_path(@merchant_1, @item_1))
        
        # When I click the link
        click_link "#{@item_1.name}"
        
        # Then I am taken to a page to edit this item
        expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
        
        # And I see a form filled in with the existing item attribute information
        expect(find_field('Name:').value).to eq(@item_1.name)
        expect(find_field('Description:').value).to eq(@item_1.description)
        expect(find_field('Unit Price:').value).to eq(@item_1.unit_price.to_s)
        
        # When I update the information in the form and I click ‘submit’
        fill_in 'Name:', with: "New Name"
        fill_in 'Description:', with: "Muy Bueno"
        fill_in 'Unit Price:', with: "666"
        click_button "Submit"


        # Then I am redirected back to the item show page where I see the updated information
        expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))

        expect(page).to have_content("Name: New Name")
        expect(page).to have_content("Description: Muy Bueno")
        expect(page).to have_content("Unit Price: 666")
        
        # And I see a flash message stating that the information has been successfully updated.
        expect(page).to have_content("Item Info Successfully Updated")
    end
  end
end

