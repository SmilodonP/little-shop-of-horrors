class AdminController < ApplicationController
  def index
    @top_5_customers = Customer.top_5_customers
    @incomplete_invoices = Invoice.unshipped_invoices
  end
end