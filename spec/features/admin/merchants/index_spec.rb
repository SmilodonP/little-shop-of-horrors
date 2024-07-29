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

      @merchant_1 = create(:merchant, status: 0)

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

      save_and_open_page
      
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

  describe "User Story #30" do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)

      visit admin_merchants_path
    end


    # 30. Admin Merchants: Top 5 Merchants by Revenue

    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see the names of the top 5 merchants by total revenue generated
    within ".top_5_merchants"
      it "displays the top 5 merchants listed by generated revenue" do
        # ADD AR QUERY TO MERCHANT MODEL FOR `#top_5_merchants`
        # `revenue` WILL BE ALIAS TO RETURN TOTAL $ AMOUNT
          # -> (DO WE NEED TO CONVERT FROM PENNIES?)

          # Notes on Revenue Calculation:
          # - Only invoices with at least one successful transaction should count towards revenue
          # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
          # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied 
          # by the quantity (do not use the item unit price)

        # I PRETTY MUCH STOLE THIS FROM US#21 -> UNLESS I'M WAY OFF, I THINK THIS LINES UP
        expect(page).to have_content("#{@merchant_1.name} - #{Merchant.top_merchant_revenue[0].revenue} in sales")
        expect(page).to have_content("#{@merchant_2.name} - #{Merchant.top_merchant_revenue[1].revenue} in sales")
        expect(page).to have_content("#{@merchant_3.name} - #{Merchant.top_merchant_revenue[2].revenue} in sales")
        expect(page).to have_content("#{@merchant_4.name} - #{Merchant.top_merchant_revenue[3].revenue} in sales")
        expect(page).to have_content("#{@merchant_5.name} - #{Merchant.top_merchant_revenue[4].revenue} in sales")
      end

      # And I see that each merchant name links to the admin merchant show page for that merchant
      it "embeds links to show pages via merchant name text for each merchant" do

        expect(page).to have_link("#{@merchant_1.name}", href: admin_merchant_path(@merchant_1))
        click_link "#{@merchant_1.name}"
        
        # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
        expect(current_path).to eq(admin_merchant_path(@merchant_1))

        # And I see the name of that merchant
        expect(page).to have_content("#{@merchant_1.name}")
      end

      # And I see the total revenue generated next to each merchant name
      it "displays total generated revenue for each merchant beside their name on their show page" do
        visit admin_merchant_path(@merchant_1)
        expect(page).to have_content("#{@merchant_1.name} - Total Revenue $#{@merchant_1.revenue}")
      end
    end
  end
end