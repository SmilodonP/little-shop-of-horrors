<<<<<<< HEAD:spec/features/admin/index_spec.rb
# Unsure of file naming 
# Should this be an index?

require "rails_helper"
=======
require "rails_helper"
# Kinda need to organize these tests better
# Add describe blocks and User Story #'s
>>>>>>> 949e68dfe316db3ddd45509237e2794e68acddd9:spec/features/admin/dashboard_spec.rb

RSpec.describe "Admin Dashboard", type: :feature do
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

    it "displays an Admin header" do
      visit admin_index_path

      expect(page).to have_content("Admin Dashboard")
    end

    it "displays links to merchant and admin invoices indices" do
      visit admin_index_path

      expect(page).to have_link("Merchants") # Is this robust enough or should 
      expect(page).to have_link("Invoices")    # these be liketests for US#22?
    end

    it "displays the names of top 5 customers with successful purchases" do
      visit admin_index_path
      
      within ".top_5_customers" do

      expect(page).to_not have_content(@customer_6.full_name)

      expect(page).to have_content("#{@customer_1.full_name} - #{Customer.top_5_customers[0].purchases} purchases")
      expect(page).to have_content("#{@customer_2.full_name} - #{Customer.top_5_customers[1].purchases} purchases")
      expect(page).to have_content("#{@customer_3.full_name} - #{Customer.top_5_customers[2].purchases} purchases")
      expect(page).to have_content("#{@customer_4.full_name} - #{Customer.top_5_customers[3].purchases} purchases")
      expect(page).to have_content("#{@customer_5.full_name} - #{Customer.top_5_customers[4].purchases} purchases")
      end 
    end

    describe "User Story #22 - Incomplete Invoices" do
      it "dislpays 'Incomplete Invoices' section & lists id's of invoices from unshipped items w/links to each invoice admin show page" do
        visit admin_index_path



        within ".incomplete_invoices" do
          expect(page).to have_content("Incomplete Invoices")
          expect(page).to have_link("#{@invoice_1.id}", :href =>"/admin/invoices/#{@invoice_1.id}")
          expect(page).to have_link("#{@invoice_2.id}", :href =>"/admin/invoices/#{@invoice_2.id}")
          expect(page).to have_link("#{@invoice_3.id}", :href =>"/admin/invoices/#{@invoice_3.id}")
          expect(page).to have_link("#{@invoice_4.id}", :href =>"/admin/invoices/#{@invoice_4.id}")
          # In that section I see a list of the ids of all invoices
          # That have items that have not yet been shipped
          # And each invoice id links to that invoice's admin show page
        end
<<<<<<< HEAD:spec/features/admin/index_spec.rb

        it "displays links to merchant and admin invoices indices" do
          # 20 . Admin Dashboard Links

          # As an admin,
          # When I visit the admin dashboard (/admin)
          # Then I see a link to the admin merchants index (/admin/merchants)
          # And I see a link to the admin invoices index (/admin/invoices)

          expect(page).to have_link("Merchants")
          expect(page).to have_link("Invoices")
        end
      end
    end
  end

  describe "US 21" do
    describe "when I visit the Admin Dasboard"
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

=======
>>>>>>> 949e68dfe316db3ddd45509237e2794e68acddd9:spec/features/admin/dashboard_spec.rb
      end
    end
  end
end