# Unsure of file naming 
# Should this be an index?


require "rails_helper"


Rspec.describe "Admin Dashboard", type: :feature do
  describe "User Story #19" do
    describe "When I visit the Admin Dashboard" do
      before :each do
        visit "/admin"
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

          expect(page).to have_link("/admin/merchants")
          expect(page).to have_link("/admin/invoices")
        end

        it "displays the names of top 5 customers with successful purchases" do
          # 21. Admin Dashboard Statistics - Top Customers

          # As an admin,
          # When I visit the admin dashboard (/admin)
          # Then I see the names of the top 5 customers
          # who have conducted the largest number of successful transactions
          # And next to each customer name I see the number of successful transactions they have
          # conducted

          
        end
    
    end
  end
end