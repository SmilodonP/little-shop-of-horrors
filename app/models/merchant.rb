class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices, through: :items

  def top_customers
    Customer
    .select("customers.id, customers.first_name, customers.last_name, count(transactions.id) as top_customers")
    .joins(invoices: :transactions)
    .where(transactions: {result: 1}, invoices: {merchant_id: id})
    .group("customers.id, customers.first_name, customers.last_name")
    .order("top_customers desc")
    .limit(5)
  end
end