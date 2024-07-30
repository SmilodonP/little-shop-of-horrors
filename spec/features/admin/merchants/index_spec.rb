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

      visit admin_merchants_path
      
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

      @merchant_1 = create(:merchant, status: 0)

      # 27. Admin Merchant Enable/Disable

      # As an admin,
      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      
      # Then next to each merchant name I see a button to disable or enable that merchant.
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")

      # When I click this button
      click_button "Enable"

      # Then I am redirected back to the admin merchants index
      expect(current_path).to eq(admin_merchants_path)
      @merchant_1.reload

      # And I see that the merchant's status has changed
      expect(@merchant_1.status).to eq("enabled")
    end

    it "updates merchant status to 'Disabled' " do
      @merchant_2 = create(:merchant, status: 1)

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
      @merchant_2.reload

      # And I see that the merchant's status has changed
      expect(@merchant_2.status).to eq("disabled")
    end
  end

  describe "User Story #28" do 
    it "can list merchants in two groups on index page" do 
      @merchant_1 = create(:merchant, status: 1)
      @merchant_2 = create(:merchant, status: 1)
      @merchant_3 = create(:merchant, status: 0)

      visit admin_merchants_path

      within '.enabled' do 
        expect(page).to have_content("Enabled Merchants")
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
      end

      within '.disabled' do 
        expect(page).to have_content("Disabled Merchants")
        expect(page).to have_content(@merchant_3.name)
      end
    end
  end

  describe "User Story #29" do 
    it "can create a new merchant" do
      visit admin_merchants_path 

      within ".new-merchant" do 
        expect(page).to have_button("Create Merchant")
      end

      click_button "Create Merchant"

      expect(current_path).to eq(new_admin_merchant_path)

      fill_in "Name", with: "Curious... Still Curious?"
      click_on "Create Merchant"
      merchant = Merchant.last

      expect(current_path).to eq(admin_merchants_path)

      within ".disabled" do 
        expect(page).to have_content(merchant.name)
      end
    end
  end
end