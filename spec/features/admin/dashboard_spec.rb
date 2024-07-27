require "rails_helper"
# Kinda need to organize these tests better
# Add describe blocks and User Story #'s

RSpec.describe "Admin Dashboard", type: :feature do
  describe "When I visit the Admin Dashboard" do
    before :each do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)

      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: 35.days.ago)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: 25.days.ago)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: 15.days.ago)
      @invoice_4 = create(:invoice, customer_id: @customer_4.id, created_at: 10.days.ago)
      @invoice_5 = create(:invoice, customer_id: @customer_5.id, created_at: 5.days.ago)
      @invoice_6 = create(:invoice, customer_id: @customer_6.id, created_at: Time.current)

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

      expect(page).to have_link("Merchants")
      expect(page).to have_link("Invoices")
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
      end
    end

    describe "User Story #23 - Date and Ordered list of incomplete invoice" do 
      it "can list oldest to newest incomplete invoice with date created" do 
        visit admin_index_path
    
        within ("#invoice-id#{@invoice_1.id}") do 
          expect(page).to have_content("#{@invoice_1.id} - Created: #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
        end

        within ("#invoice-id#{@invoice_2.id}") do
          expect(page).to have_content("#{@invoice_2.id} - Created: #{@invoice_2.created_at.strftime("%A, %B %d, %Y")}")
        end

        within "#invoice-id#{@invoice_3.id}" do
          expect(page).to have_content("#{@invoice_3.id} - Created: #{@invoice_3.created_at.strftime("%A, %B %d, %Y")}")
        end
    
        within "#invoice-id#{@invoice_4.id}" do
          expect(page).to have_content("#{@invoice_4.id} - Created: #{@invoice_4.created_at.strftime("%A, %B %d, %Y")}")
        end

        within ".incomplete_invoices" do 
          expect("Created: #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}").to appear_before("Created: #{@invoice_2.created_at.strftime("%A, %B %d, %Y")}")
          expect("Created: #{@invoice_2.created_at.strftime("%A, %B %d, %Y")}").to appear_before("Created: #{@invoice_3.created_at.strftime("%A, %B %d, %Y")}")
          expect("Created: #{@invoice_3.created_at.strftime("%A, %B %d, %Y")}").to appear_before("Created: #{@invoice_4.created_at.strftime("%A, %B %d, %Y")}")
        end
          # Next to each invoice id I see the date that the invoice was created
          # And I see the date formatted like "Monday, July 18, 2019"
          # And I see that the list is ordered from oldest to newest
      end
    end
    
  end
end