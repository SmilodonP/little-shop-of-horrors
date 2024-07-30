require 'rails_helper'

RSpec.describe Merchant, type: :model do 
  describe "validations" do
    it { should validate_presence_of(:name) }
  end
  
  describe "relationships" do 
    it { should have_many(:items)}
  end

  describe "model method tests" do
    before :each do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1, created_at: 35.days.ago)
      @invoice_2 = create(:invoice, customer: @customer_2, created_at: 25.days.ago)
      @invoice_3 = create(:invoice, customer: @customer_3, created_at: 15.days.ago)
      @invoice_4 = create(:invoice, customer: @customer_4, created_at: 10.days.ago)
      @invoice_5 = create(:invoice, customer: @customer_5, created_at: 5.days.ago)
      @invoice_6 = create(:invoice, customer: @customer_6, created_at: Time.current)

      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 0)

      @merchant_1 = create(:merchant, name: "Tarzhay")

      @item_1 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
      @item_2 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)

      @invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
      @invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_2.id, status: 0)
      @invoice_item_3 = create(:invoice_item, quantity: 15, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_3.id, status: 1)
      @invoice_item_4 = create(:invoice_item, quantity: 21, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_4.id, status: 1)
      @invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_5.id, status: 2)
      @invoice_item_6 = create(:invoice_item, quantity: 8, unit_price: 5, item_id: @item_2.id, invoice_id: @invoice_6.id, status: 2)
    end

    describe "class methods" do
      describe "top_customers" do
        it "returns the top five customers for a particular merchant" do
          expect(@merchant_1.top_five_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
        end
      end
    end

    describe "instance methods" do
      describe "items_ready_to_ship" do
        it "returns items that are ready to ship" do
          expect(@merchant_1.items_ready_to_ship).to include(@item_1)
        end
      end

      describe "sorted_items_ready_to_ship" do
        it "returns sorted items ready to ship" do
          expect(@merchant_1.sorted_items_ready_to_ship).to eq(@item_2, @item_1)
        end
      end
    end
  end
end