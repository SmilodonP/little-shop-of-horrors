class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true 
  validates :unit_price, presence: true, numericality: true 
  
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.items_ready_to_ship
    Item.joins(invoice_items: :invoice)
    .select("items.*, invoices.created_at, invoices.id as invoice_id")
    .where(invoice_items: {status:0})
    .order("invoices.created_at")
    .distinct
  end
end