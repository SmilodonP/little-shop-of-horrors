require "rails_helper"

RSpec.describe "Admin Merchant Show Page", type: :feature do
  describe "navigating to a merchant's show page" do
    describe "User Story #26" do
      it "Admin Merchant Update" do
        @merchant_1 = create(:merchant)
        
        visit admin_merchant_path(@merchant_1)

        expect(page).to have_link("Update #{@merchant_1.name} Information", href: edit_admin_merchant_path(@merchant_1))

        click_link "Update #{@merchant_1.name} Information"
        
        expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
        expect(find_field('Name').value).to eq(@merchant_1.name)

        fill_in 'Name', with: "Different Merchant Name"
        click_button "Submit"
        @merchant_1.reload
        
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
        expect(page).to have_content("Different Merchant Name")
        expect(page).to have_content("GREAT SUCCESS!")
      end
    end
  end
end