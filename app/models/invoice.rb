class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  
  validates :customer_id, presence: true
  validates :status, presence: true

  enum status: {
    "in progress": 0,
    "cancelled": 1,
    "completed": 2
  }

  def self.unshipped_invoices
    select("invoices.id, invoices.created_at").joins(:invoice_items).where.not(invoice_items: {status: 2}).order("invoices.created_at")
  end

  def total_revenue
    (invoice_items.sum("invoice_items.quantity*invoice_items.unit_price")/100.00)
  end
end
