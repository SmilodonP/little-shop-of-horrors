class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  def top_customers
    Customer
      .select("customers.id, customers.first_name, customers.last_name, COUNT(t1.id) AS transaction_count")
      .joins('INNER JOIN invoices ON invoices.customer_id = customers.id')
      .joins('INNER JOIN transactions t1 ON t1.invoice_id = invoices.id')
      .joins('INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id')
      .joins('INNER JOIN items ON items.id = invoice_items.item_id')
      .where(t1: { result: 1 }, items: { merchant_id: self.id })
      .group('customers.id, customers.first_name, customers.last_name')
      .order('transaction_count DESC')
      .limit(5)
  end
end
