require 'rails_helper'

RSpec.describe Item, type: :model do 
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end
  
  describe "relationships" do 
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "#items ready to ship" do
    it "can return all items ready to ship" do 
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
      @item_2 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)
      @item_3 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)
      @invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
      @invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: @item_2.id, invoice_id: @invoice_1.id, status: 0)
      @invoice_item_3 = create(:invoice_item, quantity: 15, unit_price: 10, item_id: @item_3.id, invoice_id: @invoice_1.id, status: 0)
      expect(Item.items_ready_to_ship).to eq([@item_1, @item_2, @item_3])
    end
  end
end