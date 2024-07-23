class Invoice < ApplicationRecord
  belongs_to :customers
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  
  enum status: {
    in_progress: 0,
    cancelled: 1,
    completed: 2
  }
end