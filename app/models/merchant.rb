class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  enum status: {disabled: 0, enabled: 1}

  def top_five_customers
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

  def items_ready_to_ship
    items.joins(:invoice_items)
    .where(invoice_items: { status: 0 })
    .distinct
  end

  def self.top_five_merchants 
    joins(:transactions)
    .select("merchants.id, merchants.name, sum(invoice_items.quantity*invoice_items.unit_price) as revenue")
    .where("transactions.result = 1")
    .group("merchants.id")
    .order("revenue desc")
    .limit(5)
  end

end
