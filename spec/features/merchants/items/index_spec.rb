require 'rails_helper'

RSpec.describe "Merchant Item", type: :feature do
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

    it "shows a list of the names of all my items" do
      visit merchant_items_path(@merchant_1)

      within "#merchant_items" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)
        expect(page).to_not have_content(@item_4.name)
      end
    end
  end

  # User Story 9
  describe "enabling & disabling items from merchant_items index page" do
    it "updates merchant_item status to 'Enabled' with button" do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, status: 0)

      @item_1 = create(:item, status: 0, merchant: @merchant_1)
      # As a merchant
      # When I visit my items index page (/merchants/:merchant_id/items)
      visit merchant_items_path(@merchant_1)

      within "#item-#{@item_1.id}" do
        # Next to each item name I see a button to disable or enable that item.
        expect(page).to have_button("Enable")     
        expect(page).to have_button("Disable")

        # When I click this button
        click_button "Enable"
      end

      expect(current_path).to eq(merchant_items(@merchant_1))
      @item_1.reload

      expect(@item_1.status).to eq("enabled")
    end

    it "updates merchant_item status to 'Disabled' with button" do
      @merchant_2 = create(:merchant)
      @item_2 = create(:item, status: 1, merchant: @merchant_2)
      
      visit merchant_items_path(@merchant_2)

      within "#merchant_item-#{@item_2.id}" do
        # Next to each item name I see a button to disable or enable that item.
        expect(page).to have_button("Enable")     
        expect(page).to have_button("Disable")

        # When I click this button
        click_button "Disable"
      end

      expect(current_path).to eq(merchant_items(@merchant_2))
      @item_2.reload

      expect(@item_2.status).to eq("disabled")
    end
  end

  # # User Story #10
  # describe "group merchant items by status" do
  #   xit "displays enabled merchant items" do
  #     @merchant_1 = create(:merchant)
  #     @item_1 = create(:item, status: 0)
  #     @item_2 = create(:item, status: 0)
  #     @item_3 = create(:item, status: 1)
  #     @item_4 = create(:item, status: 1)

      visit merchant_items_path(@merchant_1)

      within '.enabled' do 
        expect(page).to have_content("Enabled Merchant Items")
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end

      within '.disabled' do 
        expect(page).to have_content("Disabled Merchant Items")
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_4.name)
      end
    end
  end

  # # User Story #11
  # describe "creating new item from merchant index page" do
  #   xit "creates new merchant item via form" do
  #     @merchant_1 = create(:merchant, name: "Tarzhay")

      visit merchant_items_path(@merchant_1)

      expect(page).to have_link("Create New Item", new_merchant_item(@merchant_1))

      click_link "Create New Item"
      expect(current_path).to eq(new_merchant_item(@merchant_1))

      fill_in "Name: ", with: "Jinco Jeans"
      fill_in "Description: ", with: "Thug Life"
      fill_in "Unit Price: ", with: "1000"

      click_button "Submit"

      expect(current_path).to eq(merchant_items_path(@merchant_1))

      expect(page).to have_content("Jinco Jeans")
      expect(page).to have_content("Thug Life")
      expect(page).to have_content("1000")

      @new_item = Item.last
      expect(page).to have_content("#{@new_item.status}")
      expect(@new_item.status).to eq("disabled")
    end
  end

  # User Story #12
  describe "merchant items ranked by total revenue" do
    it "displays names of top 5 items" do
      @merchant_1 = create(:merchant)
      @customer_1 = create(:customer)

      @item_1 = create(:item, unit_price: 9, merchant: @merchant_1)
      @item_2 = create(:item, unit_price: 8, merchant: @merchant_1)
      @item_3 = create(:item, unit_price: 7, merchant: @merchant_1)
      @item_4 = create(:item, unit_price: 6, merchant: @merchant_1)
      @item_5 = create(:item, unit_price: 5, merchant: @merchant_1)
      @item_6 = create(:item, unit_price: 1, merchant: @merchant_1)

      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_2 = create(:invoice, customer: @customer_1)
      @invoice_3 = create(:invoice, customer: @customer_1)
      @invoice_4 = create(:invoice, customer: @customer_1)
      @invoice_5 = create(:invoice, customer: @customer_1)
      @invoice_6 = create(:invoice, customer: @customer_1)

      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 0)

      @invoice_item_1 = create(:invoice_item, quantity: 10, unit_price: 8, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 2)
      @invoice_item_2 = create(:invoice_item, quantity: 10, unit_price: 8, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 2)
      @invoice_item_3 = create(:invoice_item, quantity: 10, unit_price: 7, item_id: @item_2.id, invoice_id: @invoice_2.id, status: 2)
      @invoice_item_4 = create(:invoice_item, quantity: 10, unit_price: 7, item_id: @item_2.id, invoice_id: @invoice_2.id, status: 2)
      @invoice_item_5 = create(:invoice_item, quantity: 10, unit_price: 6, item_id: @item_3.id, invoice_id: @invoice_3.id, status: 2)
      @invoice_item_6 = create(:invoice_item, quantity: 10, unit_price: 6, item_id: @item_3.id, invoice_id: @invoice_3.id, status: 2)
      @invoice_item_7 = create(:invoice_item, quantity: 10, unit_price: 5, item_id: @item_4.id, invoice_id: @invoice_4.id, status: 2)
      @invoice_item_8 = create(:invoice_item, quantity: 10, unit_price: 5, item_id: @item_4.id, invoice_id: @invoice_4.id, status: 2)
      @invoice_item_9 = create(:invoice_item, quantity: 10, unit_price: 4, item_id: @item_5.id, invoice_id: @invoice_5.id, status: 2)
      @invoice_item_10 = create(:invoice_item, quantity: 10, unit_price: 4, item_id: @item_5.id, invoice_id: @invoice_5.id, status: 2)
      @invoice_item_6 = create(:invoice_item, quantity: 10, unit_price: 1, item_id: @item_6.id, invoice_id: @invoice_6.id, status: 0)

      visit merchant_items_path(@merchant_1)

      within "#top-5-items" 
        expect(page).to have_link("#{@item_1.name}", href: merchant_item_path(@item_1))
        expect(page).to have_link("#{@item_2.name}", href: merchant_item_path(@item_2))
        expect(page).to have_link("#{@item_3.name}", href: merchant_item_path(@item_3))
        expect(page).to have_link("#{@item_4.name}", href: merchant_item_path(@item_4))
        expect(page).to have_link("#{@item_5.name}", href: merchant_item_path(@item_5))

        expect(@item_1).to appear_before (@item_2)
        expect(@item_2).to appear_before (@item_3)
        expect(@item_3).to appear_before (@item_4)
        expect(@item_4).to appear_before (@item_5)

        # NOT SURE IF WE USE DYNAMIC TESTING HERE?
        expect(page).to have_content("#{@item_1.total_item_revenue}")
        expect(page).to have_content("#{@item_2.total_item_revenue}")
        expect(page).to have_content("#{@item_3.total_item_revenue}")
        expect(page).to have_content("#{@item_4.total_item_revenue}")
        expect(page).to have_content("#{@item_5.total_item_revenue}")

        # OR HARDCODED -> SHOULD ONLY NEED ONE OF THESE SETS
        expect(@item_1.total_item_revenue).to eq(1600)
        expect(@item_2.total_item_revenue).to eq(1400)
        expect(@item_3.total_item_revenue).to eq(1200)
        expect(@item_4.total_item_revenue).to eq(1000)
        expect(@item_5.total_item_revenue).to eq(800)
    end
  end
end