require 'rails_helper'

RSpec.describe Merchant, type: :model do 
  describe "validations" do
    it { should validate_presence_of(:name) }
  end
  
  describe "relationships" do 
    it { should have_many(:items)}
    it { should have_many(:transactions), through: :invoice_items }
  end

  describe "model method tests" do
    describe "User Story 30 query" do
      it "can return top 5 merchants based on revenue" do
        @customer_1 = create(:customer)
        @customer_2 = create(:customer)
        @customer_3 = create(:customer)
        @customer_4 = create(:customer)
        @customer_5 = create(:customer)
        @customer_6 = create(:customer)
        @invoice_1 = create(:invoice, customer_id: @customer_1.id)
        @invoice_2 = create(:invoice, customer_id: @customer_2.id)
        @invoice_3 = create(:invoice, customer_id: @customer_3.id)
        @invoice_4 = create(:invoice, customer_id: @customer_4.id)
        @invoice_5 = create(:invoice, customer_id: @customer_5.id)
        @invoice_6 = create(:invoice, customer_id: @customer_6.id)
        @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
        @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
        @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
        @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
        @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
        @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 0)
        @merchant_1 = create(:merchant)
        @merchant_2 = create(:merchant)
        @merchant_3 = create(:merchant)
        @merchant_4 = create(:merchant)
        @merchant_5 = create(:merchant)
        @item_1 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
        @item_2 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)
        @item_3 = create(:item, unit_price: 5, merchant_id: @merchant_2.id)
        @item_4 = create(:item, unit_price: 5, merchant_id: @merchant_3.id)
        @item_5 = create(:item, unit_price: 5, merchant_id: @merchant_4.id)
        @item_6 = create(:item, unit_price: 5, merchant_id: @merchant_5.id)
        
        @invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
        @invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: @item_3.id, invoice_id: @invoice_2.id, status: 0)
        @invoice_item_3 = create(:invoice_item, quantity: 15, unit_price: 10, item_id: @item_4.id, invoice_id: @invoice_3.id, status: 1)
        @invoice_item_4 = create(:invoice_item, quantity: 21, unit_price: 10, item_id: @item_5.id, invoice_id: @invoice_4.id, status: 1)
        @invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 10, item_id: @item_6.id, invoice_id: @invoice_5.id, status: 2)
        @invoice_item_6 = create(:invoice_item, quantity: 8, unit_price: 5, item_id: @item_2.id, invoice_id: @invoice_6.id, status: 2)

        expect(Merchant.top_five_merchants).to eq([@merchant_1, @merchant_4, @merchant_3, @merchant_2, @merchant_5])
      end
    end
  end

  describe "#enabled_merchants" do
    it "displays merchants based on enabled/disabled status" do
      merchant_100 = create(:merchant, status: 0)
      merchant_101 = create(:merchant, status: 1)
      merchant_102 = create(:merchant, status: 1)
      expect(Merchant.enabled_merchants).to eq([merchant_101, merchant_102])
      expect(Merchant.disabled_merchants).to eq([merchant_100])
    end
  end


  describe "class methods" do
    describe "top_customers" do
      it "returns the top five customers for a particular merchant" do
        @customer_1 = create(:customer)
        @customer_2 = create(:customer)
        @customer_3 = create(:customer)
        @customer_4 = create(:customer)
        @customer_5 = create(:customer)
        @customer_6 = create(:customer)
        @invoice_1 = create(:invoice, customer_id: @customer_1.id)
        @invoice_2 = create(:invoice, customer_id: @customer_2.id)
        @invoice_3 = create(:invoice, customer_id: @customer_3.id)
        @invoice_4 = create(:invoice, customer_id: @customer_4.id)
        @invoice_5 = create(:invoice, customer_id: @customer_5.id)
        @invoice_6 = create(:invoice, customer_id: @customer_6.id)
        @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
        @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
        @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
        @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
        @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
        @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 0)
        @merchant_1 = create(:merchant)
        @merchant_2 = create(:merchant)
        @merchant_3 = create(:merchant)
        @merchant_4 = create(:merchant)
        @merchant_5 = create(:merchant)
        @item_1 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
        @item_2 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)
        @item_3 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)
        @item_4 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)
        @item_5 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)
        @item_6 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)
        @invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
        @invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: @item_3.id, invoice_id: @invoice_2.id, status: 0)
        @invoice_item_3 = create(:invoice_item, quantity: 15, unit_price: 10, item_id: @item_4.id, invoice_id: @invoice_3.id, status: 1)
        @invoice_item_4 = create(:invoice_item, quantity: 21, unit_price: 10, item_id: @item_5.id, invoice_id: @invoice_4.id, status: 1)
        @invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 10, item_id: @item_6.id, invoice_id: @invoice_5.id, status: 2)
        @invoice_item_6 = create(:invoice_item, quantity: 8, unit_price: 5, item_id: @item_2.id, invoice_id: @invoice_6.id, status: 2)

        expect(@merchant_1.top_five_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end
    end
  end
end


