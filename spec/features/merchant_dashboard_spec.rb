require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Seymore")
    @merchant_2 = create(:merchant, name: "Audrey")

    @customer_1 = create(:customer, name: "Undertaker")
    @customer_2 = create(:customer, name: "Mankind")
    @customer_3 = create(:customer, name: "Mick Foley")
    @customer_4 = create(:customer, name: "Cactus Jack")
    @customer_5 = create(:customer, name: "Dude Love")
    @customer_6 = create(:customer, name: "Rick Flair")

    @invoice_1 = create(:invoice, merchant: @merchant_1, customer: @customer_2)
    @invoice_2 = create(:invoice, merchant: @merchant_1, customer: @customer_3)
    @invoice_3 = create(:invoice, merchant: @merchant_1, customer: @customer_3)
    @invoice_4 = create(:invoice, merchant: @merchant_1, customer: @customer_4)
    @invoice_5 = create(:invoice, merchant: @merchant_1, customer: @customer_4)
    @invoice_6 = create(:invoice, merchant: @merchant_1, customer: @customer_4)
    @invoice_7 = create(:invoice, merchant: @merchant_1, customer: @customer_5)
    @invoice_8 = create(:invoice, merchant: @merchant_1, customer: @customer_5)
    @invoice_9 = create(:invoice, merchant: @merchant_1, customer: @customer_5)
    @invoice_10 = create(:invoice, merchant: @merchant_1, customer: @customer_5)
    @invoice_11 = create(:invoice, merchant: @merchant_1, customer: @customer_6)
    @invoice_12 = create(:invoice, merchant: @merchant_1, customer: @customer_6)
    @invoice_13 = create(:invoice, merchant: @merchant_1, customer: @customer_6)
    @invoice_14 = create(:invoice, merchant: @merchant_1, customer: @customer_6)
    @invoice_15 = create(:invoice, merchant: @merchant_1, customer: @customer_6)

    
    
    

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
