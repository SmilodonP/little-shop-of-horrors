class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  def successful_transaction_count
    Customer.select("customers.id, customers.first_name, customers.last_name, count(transactions.result) as transactions").joins(:transactions).group("customers.id").where("transactions.result = 1").order("transactions desc").limit(5).transactions
  end
end