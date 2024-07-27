require "rails_helper"

RSpec.describe "Visiting the Admin Merchant Index Page", type: :feature do
  describe "User Story #24" do
    it "displays every merchant's name within the system" do
      # 24. Admin Merchants Index

      # As an admin,
      # When I visit the admin merchants index (/admin/merchants)
      # Then I see the name of each merchant in the system

      visit admin_merchant_index_path # I am not 100% on this routing

      merchant_1 = create(:merchant, name: "Tarzhay")
      merchant_2 = create(:merchant, name: "Wally World")
      merchant_3 = create(:merchant, name: "Ammuhzon")

      within ".merchants_in_system" do  # Not sure if a `within` is necessary for this test
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
      end
    end
  end

  describe "User Story #25" do 
  it "directs me to a merchant's show page where I see their name" do
    visit admin_merchant_index # Links to show pages on '/admin/merchant/index' page -> visit first.

    # 25. Admin Merchant Show
    
    # As an admin,
    # When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
    # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
    # And I see the name of that merchant

    merchant_1 = create(:merchant, name: "Tarzhay")

    expect(page).to have_link("#{merchant_1.id}", href: admin_merchant_path(merchant))
    
    expect(page).to have_content("#{merchant_1.name}")
  end
end
end