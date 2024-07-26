class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoice_items
  
  # def top_customers
  #   Customer.select("customers.id, customers.first_name, customers.last_name, count(transactions.id) as top_customers").joins(invoices: :transactions).where(transactions: {result: 1}, invoices: {merchant_id: 1}).group("customers.id, customers.first_name, customers.last_name").order("top_customers desc").limit(5)
  # end
  @top_5_customers = Customer.top_5_customers

end