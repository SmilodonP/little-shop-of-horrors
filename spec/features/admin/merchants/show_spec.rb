require "rails_helper"

# USER STORY #25 MIGHT GO IN THE INDEX_SPEC.RB
# AS IT STARTS FROM THE INDEX Page
# THOUGHTS?

RSpec.describe "Admin Merchant Show Page", type: :feature do
  describe "navigating to a merchant's show page" do
    describe "User Story #26" do
      it "Admin Merchant Update" do
        ### I'M GONNA START DOING THIS STYLE FOR TESTING WITH EACH LINE OF THE US ABOVE THE code
        ###- MIKEY LIKEY

        # 26. Admin Merchant Update
        
        # As an admin,
        merchant_1 = create(:merchant)
        
        # When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
        visit admin_merchant_path(merchant_1)
        
        ### SHOULD I ADD A `within` HERE?
        
        # Then I see a link to update the merchant's information.
        expect(page).to have_link("Update #{merchant_1.name} Information", href: edit_admin_merchant_path(merchant_1))

        # When I click the link
        click_link "Update #{merchant_1.name} Information"
        
        # Then I am taken to a page to edit this merchant
        expect(current_path).to eq(edit_admin_merchant_path(merchant_1))

        
        # And I see a form filled in with the existing merchant attribute information
        # Found me a nifty new capybara thing-a-ma-jig:
        # `find_field` locates a field with the label "Name"
        # `.value` retrieves the current value of said field ("Name")
        # So then we're expecting the current value present in the "Name" field to equal the merchant's name
        expect(find_field('Name').value).to eq(merchant_1.name)
        # save_and_open_page

        # When I update the information in the form and I click ‘submit’
        fill_in 'Name', with: "Different Merchant Name"
        click_button "Submit"

        # Then I am redirected back to the merchant's admin show page where I see the updated information
        expect(current_path).to eq(admin_merchant_path(merchant_1))
        expect(page).to have_content("Different Merchant Name")

        # And I see a flash message stating that the information has been successfully updated.
        expect(page).to have_content("GREAT SUCCESS!")
      end
    end
  end
end