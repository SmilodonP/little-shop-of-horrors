require "rails_helper"

RSpec.describe "Admin Invoices Show Page", type: :feature do
  describe "User Story #33" do
    it "can list invoice's attributes on invoice show page"  do 
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
    
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Id: #{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status}")
      expect(page).to have_content("Created: #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Customer: #{@invoice_1.customer.full_name}")
    end
  end

  describe "User Story 34" do 
    it "can list all items on invoice" do 
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
      @item_2 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
      @invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: @item_2.id, invoice_id: @invoice_1.id)
    
      visit admin_invoice_path(@invoice_1)

      within "#item-#{@item_1.id}" do 
        expect(page).to have_content("Name: #{@item_1.name}")
        expect(page).to have_content("Quantity: #{@invoice_item_1.quantity}")
        expect(page).to have_content("Price: #{@invoice_item_1.unit_price}")
        expect(page).to have_content("Created: #{@invoice_item_1.status}")
      end

      within  "#item-#{@item_2.id}" do 
        expect(page).to have_content("Name: #{@item_2.name}")
        expect(page).to have_content("Quantity: #{@invoice_item_2.quantity}")
        expect(page).to have_content("Price: #{@invoice_item_2.unit_price}")
        expect(page).to have_content("Created: #{@invoice_item_2.status}")
      end
    end
  end

    describe "User Story #35" do 
      it "can display total revenue from invoice" do 
        @customer_1 = create(:customer)
        @invoice_1 = create(:invoice, customer_id: @customer_1.id)
        @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
        @merchant_1 = create(:merchant)
        @item_1 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
        @item_2 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
        @invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id)
        @invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: @item_2.id, invoice_id: @invoice_1.id)
  
        visit admin_invoice_path(@invoice_1)

        within ".total-revenue" do 
          expect(page).to have_content("Total Revenue: $#{@invoice_1.total_revenue.round(2)}")
        end
      end
    end

end
