require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "query methods" do
    it "can #successful_transaction_count" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)
      customer_4 = create(:customer)
      customer_5 = create(:customer)
      customer_6 = create(:customer)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_2 = create(:invoice, customer_id: customer_2.id)
      invoice_3 = create(:invoice, customer_id: customer_3.id)
      invoice_4 = create(:invoice, customer_id: customer_4.id)
      invoice_5 = create(:invoice, customer_id: customer_5.id)
      invoice_6 = create(:invoice, customer_id: customer_6.id)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: 1)
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: 1)
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: 1)
      transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: 1)
      transaction_5 = create(:transaction, invoice_id: invoice_5.id, result: 1)
      transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: 0)
      merchant_1 = create(:merchant, name: "Tarzhay")
      item_1 = create(:item, unit_price: 10, merchant_id: merchant_1.id)
      invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = create(:invoice_item, quantity: 39, unit_price: 10, item_id: item_1.id, invoice_id: invoice_2.id)
      invoice_item_3 = create(:invoice_item, quantity: 38, unit_price: 10, item_id: item_1.id, invoice_id: invoice_3.id)
      invoice_item_4 = create(:invoice_item, quantity: 5, unit_price: 10, item_id: item_1.id, invoice_id: invoice_4.id)
      invoice_item_5 = create(:invoice_item, quantity: 5, unit_price: 10, item_id: item_1.id, invoice_id: invoice_5.id)
      invoice_item_6 = create(:invoice_item, quantity: 5, unit_price: 10, item_id: item_1.id, invoice_id: invoice_6.id)

      expect(Customer.top_5_customers).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])
    end
  end

  it "can return full name" do 
    customer_1 = create(:customer)

    expect(customer_1.full_name).to eq("#{customer_1.first_name} #{customer_1.last_name}")
  end

  describe "model method tests" do
    describe "class methods" do
      describe "successful_transactions" do
        it "returns the top five customers for a particular merchant" do
          merchant_1 = create(:merchant, name: "Seymore")
          merchant_2 = create(:merchant, name: "Audrey")
      
          customer_1 = create(:customer, first_name: "The", last_name: "Undertaker")
          customer_2 = create(:customer, first_name: "Man", last_name: "kind")
          customer_3 = create(:customer, first_name: "Mick", last_name: "Foley")
          customer_4 = create(:customer, first_name: "Cactus", last_name: "Jack")
          customer_5 = create(:customer, first_name: "Dude", last_name: "Love")
          customer_6 = create(:customer, first_name: "Rick", last_name: "Flair")
      
          invoice_1 = create(:invoice, customer: customer_2)
          invoice_2 = create(:invoice, customer: customer_3)
          invoice_3 = create(:invoice, customer: customer_3)
          invoice_4 = create(:invoice, customer: customer_4)
          invoice_5 = create(:invoice, customer: customer_4)
          invoice_6 = create(:invoice, customer: customer_4)
          invoice_7 = create(:invoice, customer: customer_5)
          invoice_8 = create(:invoice, customer: customer_5)
          invoice_9 = create(:invoice, customer: customer_5)
          invoice_10 = create(:invoice, customer: customer_5)
          invoice_11 = create(:invoice, customer: customer_6)
          invoice_12 = create(:invoice, customer: customer_6)
          invoice_13 = create(:invoice, customer: customer_6)
          invoice_14 = create(:invoice, customer: customer_6)
          invoice_15 = create(:invoice, customer: customer_6)
          invoice_16 = create(:invoice, customer: customer_6)
      
          transaction_1 = create(:transaction, invoice: invoice_1, result: 1)
          transaction_2 = create(:transaction, invoice: invoice_2, result: 1)
          transaction_3 = create(:transaction, invoice: invoice_3, result: 1)
          transaction_4 = create(:transaction, invoice: invoice_4, result: 1)
          transaction_5 = create(:transaction, invoice: invoice_5, result: 0)
          transaction_6 = create(:transaction, invoice: invoice_6, result: 1)
          transaction_7 = create(:transaction, invoice: invoice_7, result: 1)
          transaction_8 = create(:transaction, invoice: invoice_8, result: 1)
          transaction_9 = create(:transaction, invoice: invoice_9, result: 1)
          transaction_10 = create(:transaction, invoice: invoice_10, result: 0)
          transaction_11 = create(:transaction, invoice: invoice_11, result: 1)
          transaction_12 = create(:transaction, invoice: invoice_12, result: 1)
          transaction_13 = create(:transaction, invoice: invoice_13, result: 1)
          transaction_14 = create(:transaction, invoice: invoice_14, result: 1)
          transaction_15 = create(:transaction, invoice: invoice_15, result: 1)
          transaction_16 = create(:transaction, invoice: invoice_16, result: 1)
        
          item_1 = create(:item, name: "singlet", merchant: merchant_1)
          item_2 = create(:item, name: "boots", merchant: merchant_1)
          item_3 = create(:item, name: "belt", merchant: merchant_1)
          item_4 = create(:item, name: "chair", merchant: merchant_2)
      
          invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_15, status: 0)
          invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_14, status: 1)
          invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_13, status: 2)
          
          expect(customer_6.successful_transactions).to eq(5)
          expect(customer_5.successful_transactions).to eq(3)
        end
      end
    end

    describe "instance methods" do
    end
  end
end