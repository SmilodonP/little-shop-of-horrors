require 'csv'

def import_csv(path, model)
  CSV.foreach(path, headers: true) do |row|
    model.create!(row.to_hash)
  end
end

task :all => :environment do
  import_csv("db/data/customers.csv", Customer)
  import_csv("db/data/merchants.csv", Merchant)
  import_csv("db/data/invoices.csv", Invoice)
  import_csv("db/data/items.csv", Item)
  import_csv("db/data/invoice_items.csv", InvoiceItem)
  import_csv("db/data/transactions.csv", Transaction)
end

# Could potentially refactor even more using enumerable 
# How to use csv_load:all  ?

# namespace :csv_load do
#   desc "imports data from a csv file"

#   task :customers => :environment do
#     import_csv("db/data/customers.csv", Customer)
#   end

#   task :merchants => :environment do
#     import_csv("db/data/merchants.csv", Merchant)
#   end

#   task :invoices => :environment do
#     import_csv("db/data/invoices.csv", Invoice)
#   end
  
#   task :items => :environment do
#     import_csv("db/data/items.csv", Item)
#   end
  
#   task :invoice_items => :environment do
#     import_csv("db/data/invoice_items.csv", InvoiceItem)
#   end
  
#   task :transactions => :environment do
#     import_csv("db/data/transactions.csv", Transaction)
#   end
end
