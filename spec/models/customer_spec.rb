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
    xit "can #successful_transaction_count" do
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

  xit "can return full name" do 
    customer_1 = create(:customer)

    expect(customer_1.full_name).to eq("#{customer_1.first_name} #{customer_1.last_name}")
  end
end