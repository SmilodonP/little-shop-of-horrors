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
      .select("customers.id, customers.first_name, customers.last_name, COUNT(transactions.id) AS transaction_count")
      .joins(invoices: [:transactions, { invoice_items: :item }])
      .where(transactions: { result: 1 }, items: { merchant_id: id })
      .group('customers.id')
      .order(transaction_count: :desc)
      .limit(5)
    
    # customers.joins(invoices: :transactions)
    #   .select("customers.*, COUNT(transactions.id) as transactions")
    #   .where(transactions: {result: 0})
    #   .group("customer.id")
    #   .order("COUNT(transactions.id) DESC")
    #   .limit(5)
    
    # customers
    # .select("customers.id, customers.first_name, customers.last_name, count(transactions.id) as transaction_count")
    # .joins(invoices: :transactions)
    # .joins("INNER JOIN transactions ON transactions.invoice_id = invoices.id")
    # .joins("INNER JOIN items ON items.id = invoice_items.item_id")
    # .where(transactions: { result: 1 }, items: { merchant_id: self.id })
    # .group("customers.id, customers.first_name, customers.last_name")
    # .order("transaction_count desc")
    # .limit(5)

    # customers
    #   .joins(transactions: {invoice: :customer})
    #   .where("invoices.status = 2")
    #   .where('result = 1')
    #   .select("customers.*, count('transactions.result') as customer_transactions")
    #   .group('customers.id')
    #   .order("customer_transactions DESC")
    #   .distinct
    #   .limit(5)
  end

  def items_ready_to_ship
    Item
    .joins(invoice_items: :invoice)
    .select("items.*, invoices.created_at, invoices.id as invoice_id")
    .where(invoice_items: {status:0})
    .order("invoices.created_at")
    .distinct
  end

  # def self.top_five_merchants 
  #   joins(:transactions)
  #   .select("merchants.id, merchants.name, sum(invoice_items.quantity*invoice_items.unit_price) as revenue")
  #   .where("transactions.result = 1")
  #   .group("merchants.id")
  #   .order("revenue desc")
  #   .limit(5)
  # end

end
