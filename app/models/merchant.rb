class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices, through: :items

  def top_customers
    Customer
    .select("customers.id, customers.first_name, customers.last_name, count(transactions.id) as top_customers")
    .joins(invoices: { invoice_items: :item})
    .joins('INNER JOIN transactions ON transactions.invoice_id = invoices.id')
    .where(transactions: { result: 1 }, items: { merchant_id: self.id })
    .group("customers.id, customers.first_name, customers.last_name")
    .order("top_customers desc")
    .limit(5)
  end
end