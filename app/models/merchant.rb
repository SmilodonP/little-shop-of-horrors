class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true

  has_many :items
  
  enum status: {"disabled": 0, "enabled": 1}

end

