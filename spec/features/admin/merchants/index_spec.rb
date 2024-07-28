require "rails_helper"

RSpec.describe "Visiting the Admin Merchant Index Page", type: :feature do
  describe "User Story #24" do
    it "displays every merchant's name within the system" do
      # 24. Admin Merchants Index

      # As an admin,
      # When I visit the admin merchants index (/admin/merchants)
      # Then I see the name of each merchant in the system

      # DON'T NEED HARDCODED NAMES WITH MERCHANTS HERE
      merchant_1 = create(:merchant, name: "Tarzhay")
      merchant_2 = create(:merchant, name: "Wally World")
      merchant_3 = create(:merchant, name: "Ammuhzon")

      visit admin_merchants_path # I am not 100% on this routing

      within ".merchants_in_system" do  # Not sure if a `within` is necessary for this test
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
      end
    end
  end

  describe "User Story #25" do 
    it "directs me to a merchant's show page where I see their name" do
      
      merchant_1 = create(:merchant)
      
      # 25. Admin Merchant Show
      
      # As an admin,
      visit admin_merchants_path # Links to show pages on '/admin/merchant/index' page -> visit first.
      
      # When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
      expect(page).to have_link("#{merchant_1.name}", href: admin_merchant_path(merchant_1))
      click_link "#{merchant_1.name}"
      
      # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
      expect(current_path).to eq(admin_merchant_path(merchant_1))

      # And I see the name of that merchant
      expect(page).to have_content("#{merchant_1.name}")
    end
  end

  describe "User Story #27" do
    it "updates merchant status to 'Enabled' " do
      ### NEED MERCHANT INSTANCES
        # MAYBE DO MORE THAN ONE TO DEMONSTRATE BOTH ENABLE & DISABLE
        # DO WE CREATE MERCHANT INSTANCES WITH DEFAULT STATUS VALUE??
          # LIKELY USE ENUMS AS WELL FOR THAT
            # PROBABLY NEED A MIGRATION FOR THIS
      
      merchant_1 = create(:merchant)

      # 27. Admin Merchant Enable/Disable

      # As an admin,
      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then next to each merchant name I see a button to disable or enable that merchant.
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")
      
      # When I click this button
      # within "merchant-#{merchant_1.id}" do
        click_button "Enable"
      # end

      # Then I am redirected back to the admin merchants index
      expect(current_path).to eq(admin_merchants_path)
      
      # And I see that the merchant's status has changed
        # I'M ASSUMING `MERCHANT STATUS` REFERES TO "ENABLED" OR "DISABLED" ?
          # I think this requires a migration
      expect(merchant_1.status).to eq("enabled")
    end

    it "updates merchant status to 'Disabled' " do
      merchant_2 = create(:merchant, status: 0)

      # 27. Admin Merchant Enable/Disable

      # As an admin,
      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path

      # Then next to each merchant name I see a button to disable or enable that merchant.
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")

      # When I click this button
      click_button "Disable"
      
      # Then I am redirected back to the admin merchants index
      expect(current_path).to eq(admin_merchants_path)
      
      # And I see that the merchant's status has changed
      expect(merchant_2.status).to eq("disabled")
    end
  end
end