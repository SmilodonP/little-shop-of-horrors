class Customer < ApplicationRecord
  has_many :invoices
  has_many :items, through: :invoices
  has_many :merchants, through: :items
  has_many :items

  validates_presence_of :first_name
  validates_presence_of :last_name
end