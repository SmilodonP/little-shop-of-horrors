require 'csv'

def import_csv(path, model)
  CSV.foreach(path, headers: true) do |row|
    model.create!(row.to_hash)
  end
end

namespace :csv_load do
  desc "imports data from a csv file"

  task :customers => :environment do
    import_csv("db/data/customers.csv", Customer)
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task :merchants => :environment do
    import_csv("db/data/merchants.csv", Merchant)
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task :invoices => :environment do
    import_csv("db/data/invoices.csv", Invoice)
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end
  
  task :items => :environment do
    import_csv("db/data/items.csv", Item)
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end
  
  task :invoice_items => :environment do
    import_csv("db/data/invoice_items.csv", InvoiceItem)
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end
  
  task :transactions => :environment do
    import_csv("db/data/transactions.csv", Transaction)
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task :all => [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]
  
end
