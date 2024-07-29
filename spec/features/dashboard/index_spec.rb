require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Seymore")
    @merchant_2 = create(:merchant, name: "Audrey")

    @customer_1 = create(:customer, first_name: "The", last_name: "Undertaker")
    @customer_2 = create(:customer, first_name: "Man", last_name: "kind")
    @customer_3 = create(:customer, first_name: "Mick", last_name: "Foley")
    @customer_4 = create(:customer, first_name: "Cactus", last_name: "Jack")
    @customer_5 = create(:customer, first_name: "Dude", last_name: "Love")
    @customer_6 = create(:customer, first_name: "Rick", last_name: "Flair")

    @invoice_1 = create(:invoice, customer: @customer_2)
    @invoice_2 = create(:invoice, customer: @customer_3)
    @invoice_3 = create(:invoice, customer: @customer_3)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_4)
    @invoice_6 = create(:invoice, customer: @customer_4)
    @invoice_7 = create(:invoice, customer: @customer_5)
    @invoice_8 = create(:invoice, customer: @customer_5)
    @invoice_9 = create(:invoice, customer: @customer_5)
    @invoice_10 = create(:invoice, customer: @customer_5)
    @invoice_11 = create(:invoice, customer: @customer_6)
    @invoice_12 = create(:invoice, customer: @customer_6)
    @invoice_13 = create(:invoice, customer: @customer_6)
    @invoice_14 = create(:invoice, customer: @customer_6)
    @invoice_15 = create(:invoice, customer: @customer_6)
    @invoice_16 = create(:invoice, customer: @customer_6)

    @transaction_1 = create(:transaction, invoice: @invoice_1, result: 1)
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: 1)
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: 1)
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: 1)
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: 0)
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: 1)
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: 1)
    @transaction_9 = create(:transaction, invoice: @invoice_9, result: 1)
    @transaction_10 = create(:transaction, invoice: @invoice_10, result: 0)
    @transaction_11 = create(:transaction, invoice: @invoice_11, result: 1)
    @transaction_12 = create(:transaction, invoice: @invoice_12, result: 1)
    @transaction_13 = create(:transaction, invoice: @invoice_13, result: 1)
    @transaction_14 = create(:transaction, invoice: @invoice_14, result: 1)
    @transaction_15 = create(:transaction, invoice: @invoice_15, result: 1)
    @transaction_16 = create(:transaction, invoice: @invoice_16, result: 1)
  
    @item_1 = create(:item, name: "singlet", merchant: @merchant_1)
    @item_2 = create(:item, name: "boots", merchant: @merchant_1)
    @item_3 = create(:item, name: "belt", merchant: @merchant_1)
    @item_4 = create(:item, name: "chair", merchant: @merchant_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_15, status: 0)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_14, status: 1)
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_13, status: 2)
    @invoice_item_4 = create(:invoice_item, item: @item_1, invoice: @invoice_9, status: 0)
    @invoice_item_5 = create(:invoice_item, item: @item_2, invoice: @invoice_8, status: 1)
    @invoice_item_6 = create(:invoice_item, item: @item_3, invoice: @invoice_6, status: 2)
    @invoice_item_7 = create(:invoice_item, item: @item_3, invoice: @invoice_5, status: 2)
    @invoice_item_4 = create(:invoice_item, item: @item_1, invoice: @invoice_2, status: 0)
    @invoice_item_5 = create(:invoice_item, item: @item_2, invoice: @invoice_1, status: 1)
  end
  context "As a merchant," do
    describe "when I visit my merchant dashboard," do
      # User Story 1
      it "I see my merchant name" do
        visit merchant_dashboard_index_path(@merchant_1)

        within("#merchant") do 
          expect(page).to have_content("Name: #{ @merchant_1.name }") 
          expect(page).to_not have_content("#{ @merchant_2.name }")
        end
      end

      # User Story 2
      it "I see a link to my merchant items index," do
        visit merchant_dashboard_index_path(@merchant_1)
        within("#merchant_links") do
          expect(page).to have_link("Items Index")
        end
      end

      it "I see a link to my merchant invoices index," do
        visit merchant_dashboard_index_path(@merchant_1)
        within("#merchant_links") do
          expect(page).to have_link("Invoices Index")
        end
      end
      
      # User Story 3
      it "and I see the names of the 5 customers with whom I have the most completed transactions, as well as the number of each customer's successful transactions." do
        visit merchant_dashboard_index_path(@merchant_1)
        
        within "#top_customers" do
          expect(page).to have_content("#{@customer_6.first_name} #{@customer_6.last_name}: 3")
          expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}: 2")
          expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}: 1")
          expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}: 1")
          expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}: 1")
          expect(page).to_not have_content("#{@customer_1.first_name} #{@customer_6.last_name}: 0")
        end
      end

      # User Story 4
      xit "displays items ready to ship with a link to the invoice" do 
        visit merchant_path(@merchant_1)
        # save_and_open_page
        within "#items_ready_to_ship" do
        
        expect(page).to have_content("Items Ready to Ship")

          expect(page).to have_content(@item_2.name)
          expect(page).to_not have_content(@item_1.name)
          expect(page).to_not have_content(@item_3.name)

          expect(page).to have_link("Invoice #{@invoice_14.id}")
          expect(page).to have_link("Invoice #{@invoice_15.id}")
        end
      end
    end
  end
end
