require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:status) }
  end

  describe "#unshipped_invoices" do
    it "returns id #'s of unshipped invoices" do
      customer_1 = create(:customer)
      customer_3 = create(:customer)
      customer_5 = create(:customer)
      merchant_1 = create(:merchant, name: "Tarzhay")
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_3 = create(:invoice, customer_id: customer_3.id)
      invoice_5 = create(:invoice, customer_id: customer_5.id)
      item_1 = create(:item, unit_price: 10, merchant_id: merchant_1.id)
      invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: item_1.id, invoice_id: invoice_1.id, status: 0)
      invoice_item_3 = create(:invoice_item, quantity: 15, unit_price: 10, item_id: item_1.id, invoice_id: invoice_3.id, status: 1)
      invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 10, item_id: item_1.id, invoice_id: invoice_5.id, status: 2)

      # Shouldn't #unshipped_invoices return the id #'s without 'pluck'?
      expect(Invoice.unshipped_invoices.pluck(:id)).to eq([invoice_1.id, invoice_3.id])
    end
  end
end