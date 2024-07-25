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
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_2 = create(:invoice, customer_id: customer_2.id)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: 1)
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: 0)
      merchant_1 = create(:merchant, name: "Tarzhay")
      item_1 = create(:item, unit_price: 10, merchant_id: merchant_1.id)
      invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: item_1.id, invoice_id: invoice_2.id)

      expect(customer_1.successful_transaction_count).to eq(1)
      expect(customer_2.successful_transaction_count).to eq(0)
    end
  end
end