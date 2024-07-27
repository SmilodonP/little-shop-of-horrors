require "rails_helper"


RSpec.describe "Admin Merchant Show Page", type: :feature do
  describe "navigating to a merchant's show page" do
    it "directs me to a merchant's show page where I see their name" do
      visit admin_merchant_index # Links to show pages on '/admin/merchant/index' page -> visit first.

      # 25. Admin Merchant Show
      
      # As an admin,
      # When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
      # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
      # And I see the name of that merchant

      merchant_1 = create(:merchant, name: "Tarzhay")

      expect(page).to have_link("#{merchant_1.id}", :href =>"/admin/merchant/#{merchant_1.id}")
      
      expect(page).to have_content("#{merchant_1.name}")
    end
  end
end