class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  def successful_transaction_count
    Customer.transactions
    # Customer.select("customers.id, count(transactions.result) as poop").joins(:invoices, :transactions).where("transactions.result = 1").group(:result).order(:poop).limit(5)
    # select customers.id, count(transactions.result) as poop
    # from customers
    # inner join invoices on customers.id = invoices.customer_id 
    # inner join transactions on invoices.id = transactions.invoice_id 
    # WHERE transactions.result = 1
    # group by customers.id 
    # order by poop desc;
  end
end