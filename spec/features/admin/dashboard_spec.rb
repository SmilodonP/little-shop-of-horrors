# Unsure of file naming 
# Should this be an index?


require "rails_helper"


RSpec.describe "Admin Dashboard", type: :feature do
  describe "User Story #19" do
    describe "When I visit the Admin Dashboard" do
      before :each do
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
        @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 0)
        @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 1)

        @merchant_1 = create(:merchant, name: "Tarzhay")

        @item_1 = create(:item, unit_price: 10, merchant_id: @merchant_1.id)
        @item_2 = create(:item, unit_price: 5, merchant_id: @merchant_1.id)

        @invoice_item_1 = create(:invoice_item, quantity: 40, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_1.id)
        @invoice_item_2 = create(:invoice_item, quantity: 9, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_2.id)
        @invoice_item_3 = create(:invoice_item, quantity: 15, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_3.id)
        @invoice_item_4 = create(:invoice_item, quantity: 21, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_4.id)
        @invoice_item_5 = create(:invoice_item, quantity: 1, unit_price: 10, item_id: @item_1.id, invoice_id: @invoice_5.id)
        @invoice_item_6 = create(:invoice_item, quantity: 8, unit_price: 5, item_id: @item_2.id, invoice_id: @invoice_6.id)

        # visit "/admin"
        visit admin_index_path
      end

        it "displays an Admin header" do
          # 19. Admin Dashboard
      
          # As an admin,
          # When I visit the admin dashboard (/admin)
          # Then I see a header indicating that I am on the admin dashboard

          expect(page).to have_content("Admin Dashboard")
        end

        it "displays links to merchant and admin invoices indices" do
          # 20 . Admin Dashboard Links

          # As an admin,
          # When I visit the admin dashboard (/admin)
          # Then I see a link to the admin merchants index (/admin/merchants)
          # And I see a link to the admin invoices index (/admin/invoices)

          expect(page).to have_link("Merchants")
          expect(page).to have_link("Invoices")
        end

        it "displays the names of top 5 customers with successful purchases" do
          # 21. Admin Dashboard Statistics - Top Customers

          # As an admin,
          # When I visit the admin dashboard (/admin)
          # Then I see the names of the top 5 customers
          within ".top_5_customers" do
            expect(page).to_not have_content(@customer_5.name)

            expect(page).to have_content("1. #{@customer_1.name}-#{@customer_1.successful_transaction_count} purchases")
            expect(page).to have_content("2. #{@customer_4.name}-#{@customer_4.successful_transaction_count} purchases")
            expect(page).to have_content("3. #{@customer_3.name}-#{@customer_3.successful_transaction_count} purchases")
            expect(page).to have_content("4. #{@customer_2.name}-#{@customer_2.successful_transaction_count} purchases")
            expect(page).to have_content("5. #{@customer_6.name}-#{@customer_6.successful_transaction_count} purchases")
          end
          # who have conducted the largest number of successful transactions
          # And next to each customer name I see the number of successful transactions they have
          # conducted

          # Might need to create a helper method in customer model to find these and call here

        end
    
    end
  end
end