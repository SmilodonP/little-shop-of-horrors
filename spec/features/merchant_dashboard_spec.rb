require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Seymore")
    @merchant_2 = create(:merchant, name: "Audrey")

    @customer_1 = create(:customer, first_name: "Under", last_name: "taker")
    @customer_2 = create(:customer, first_name: "Man", last_name: "kind")
    @customer_3 = create(:customer, first_name: "Mick", last_name: "Foley")
    @customer_4 = create(:customer, first_name: "Cactus", last_name: "Jack")
    @customer_5 = create(:customer, first_name: "Dude", last_name: "Love")
    @customer_6 = create(:customer, first_name: "Rick", last_name: "Flair")

    @invoice_1 = create(:invoice, customer: @customer_2)
    @invoice_2 = create(:invoice, customer: @customer_3)
    @invoice_3 = create(:invoice, customer: @customer_3)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_4)
    @invoice_6 = create(:invoice, customer: @customer_4)
    @invoice_7 = create(:invoice, customer: @customer_5)
    @invoice_8 = create(:invoice, customer: @customer_5)
    @invoice_9 = create(:invoice, customer: @customer_5)
    @invoice_10 = create(:invoice, customer: @customer_5)
    @invoice_11 = create(:invoice, customer: @customer_6)
    @invoice_12 = create(:invoice, customer: @customer_6)
    @invoice_13 = create(:invoice, customer: @customer_6)
    @invoice_14 = create(:invoice, customer: @customer_6)
    @invoice_15 = create(:invoice, customer: @customer_6)

    @transaction_1 = create(:transaction, invoice: @invoice_1, result: 1)
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: 1)
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: 1)
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: 1)
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: 0)
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: 1)
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: 1)
    @transaction_9 = create(:transaction, invoice: @invoice_9, result: 1)
    @transaction_10 = create(:transaction, invoice: @invoice_10, result: 0)
    @transaction_11 = create(:transaction, invoice: @invoice_11, result: 1)
    @transaction_12 = create(:transaction, invoice: @invoice_12, result: 1)
    @transaction_13 = create(:transaction, invoice: @invoice_13, result: 1)
    @transaction_14 = create(:transaction, invoice: @invoice_14, result: 1)
    @transaction_15 = create(:transaction, invoice: @invoice_15, result: 1)
  
    @item_1 = create(:item, name: "singlet", merchant: @merchant_1)
    @item_2 = create(:item, name: "boots", merchant: @merchant_1)
    @item_3 = create(:item, name: "belt", merchant: @merchant_1)
    @item_4 = create(:item, name: "chair", merchant: @merchant_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_15, status: 0)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_14, status: 1)
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_13, status: 2)
  end
  
  # User Story 1
  it "Has the name of the merchant when I visit that merchants dashboard" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

      within("#merchant") do 
        expect(page).to have_content("#{@merchant_1.name}")
        expect(page).to_not have_content("#{@merchant_2.name}")
    end
  end

  # User Story 2
  it "Has a link to the merchant items index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("Items Index")
  end

  it "Has a link to the invoices index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    
    expect(page).to have_link("Invoices Index")
  end

  # User Story 3
  it "displays the names of the top 5 customers and next to their name it shows the number of successful transactions" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    within "#top_customers" do
    #save_and_open_page
      expect(page).to have_content("#{@customer_6.first_name} #{@customer_6.last_name}: 5")
      expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}: 3")
      expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}: 2")
      expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}: 2")
      expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}: 1")
      
      expect(page).to_not have_content("#{@customer_1.first_name} #{@customer_6.last_name}: 0")
    end
  end

  # User Story 4
  it "displays items ready to ship with a link to the invoice" do 
    visit "/merchants/#{@merchant_1.id}/dashboard"

    within "#items_ready_to_ship" do

      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_3.name)

      expect(page).to have_link("Invoice #{@invoice_14}")
    end
  end

  
end
