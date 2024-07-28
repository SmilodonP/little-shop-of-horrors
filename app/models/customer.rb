class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.top_5_customers
    self.select("customers.id, customers.first_name, customers.last_name, count(transactions.result) as purchases")
        .joins(:transactions)
        .group("customers.id")
        .where("transactions.result = 1")
        .order(purchases: :desc)
        .limit(5)
  end

  def self.top_5_customers_for_merchant(merchant_id)
    self.select("customers.id, customers.first_name, customers.last_name, count(transactions.result) as purchases")
        .joins(:transactions)
        .joins("INNER JOIN invoices ON invoices.customer_id = customers.id")
        .joins("INNER JOIN merchants ON merchants.id = invoices.merchant_id")
        .group("customers.id")
        .where("transactions.result = 1")
        .where("merchants.id = ?", merchant_id)
        .order(purchases: :desc)
        .limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end