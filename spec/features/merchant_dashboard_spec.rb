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
end
