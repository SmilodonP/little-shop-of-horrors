require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Seymore")
    @merchant_2 = create(:merchant, name: "Audrey")
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
end
