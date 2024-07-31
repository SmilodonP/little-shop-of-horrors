require "rails_helper"

RSpec.describe "Visiting the Admin Invoices Index Page", type: :feature do
  describe "User Story #32" do
    it "can list all invoice id's with links to respective show pages" do 
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, customer_id: @customer_1.id)
      @invoice_3 = create(:invoice, customer_id: @customer_1.id)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
      @invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_item_3 = create(:invoice_item, quantity: 15, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_2.id)
      @invoice_item_4 = create(:invoice_item, quantity: 21, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_2.id)
      @invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_3.id)
      @invoice_item_6 = create(:invoice_item, quantity: 8, unit_price: 5, item_id: @item_1.id, invoice_id: @invoice_3.id)
    
      visit admin_invoices_path

      expect(page).to have_link("#{@invoice_1.id}", :href => admin_invoice_path(@invoice_1))
      expect(page).to have_link("#{@invoice_2.id}", :href => admin_invoice_path(@invoice_2))
      expect(page).to have_link("#{@invoice_3.id}", :href => admin_invoice_path(@invoice_3))
    end
  end

end