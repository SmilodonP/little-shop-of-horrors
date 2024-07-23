require 'csv'

def import_csv(path, model)
  CSV.foreach(path, headers: true) do |row|
    model.create(row.to_hash)
  end
end

namespace :csv_load do
  desc "imports data from as csv file"
  task :customers => :enviroment do
    import_csv("db/data/customers.csv", Customer)
  end

  task :invoices => :enviroment do
    import_csv("db/data/invoices.csv", Invoice)
  end

  task :merchants => :enviroment do
    import_csv("db/data/merchants.csv", Merchant)
  end

  task :transactions => :enviroment do
    import_csv("db/data/transactions.csv", Transaction)
  end

  task :items => :enviroment do
    import_csv("db/data/items.csv", Item)
  end

  task :invoice_items => :enviroment do
    import_csv("db/data/invoice_items.csv", InvoiceItem)
  end
end