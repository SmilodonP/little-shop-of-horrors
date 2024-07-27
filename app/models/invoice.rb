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
    # select(:id).joins(:invoice_items).where("invoice_items.status != 2")
    select(:id).joins(:invoice_items).where.not(invoice_items: {status: 2})
  end
end