require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant = create(:merchant)
  end
  
  # User Story 1
  it "Has the name of the merchant when I visit that merchants dashboard" do
    visit "/merchants/#{@merchant.id}/dashboard"

      within("#merchant") do 
        expect(page).to have_content(@merchant.name)
    end
  end

  # User Story 2
  it "Has a link to the merchant items index" do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_link("Items Index")
  end

  it "Has a link to the merchant invoices index" do
    save_and_open_page
    expect(page).to have_link("Invoices Index")
  end
end
