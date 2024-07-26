require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Seymore")
    @merchant_2 = create(:merchant, name: "Audrey")

    @customer_1 = create(:customer, first_name: "Under" last_name: "taker")
    @customer_2 = create(:customer, first_name: "Man" last_name: "kind")
    @customer_3 = create(:customer, first_name: "Mick" last_name: "Foley")
    @customer_4 = create(:customer, first_name: "Cactus" last_name: "Jack")
    @customer_5 = create(:customer, first_name: "Dude" last_name: "Love")
    @customer_6 = create(:customer, first_name: "Rick" last_name: "Flair")

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

    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)
    @transaction_4 = create(:transaction, invoice: @invoice_4)
    @transaction_5 = create(:transaction, invoice: @invoice_5)
    @transaction_6 = create(:transaction, invoice: @invoice_6)
    @transaction_7 = create(:transaction, invoice: @invoice_7)
    @transaction_8 = create(:transaction, invoice: @invoice_8)
    @transaction_9 = create(:transaction, invoice: @invoice_9)
    @transaction_10 = create(:transaction, invoice: @invoice_10)
    @transaction_11 = create(:transaction, invoice: @invoice_11)
    @transaction_12 = create(:transaction, invoice: @invoice_12)
    @transaction_13 = create(:transaction, invoice: @invoice_13)
    @transaction_14 = create(:transaction, invoice: @invoice_14)
    @transaction_15 = create(:transaction, invoice: @invoice_15)
    
    

  end
  
  # User Story 1
  it "Has the name of the merchant when I visit that merchants dashboard" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

      within("#merchant") do 
        expect(page).to have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
    end
  end

  # User Story 2
  it "Has a link to the merchant items index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("Items Index")
  end

  it "Has a link to the merchant invoices index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    #save_and_open_page
    expect(page).to have_link("Invoices Index")
  end

  # User Story 3
  
end
