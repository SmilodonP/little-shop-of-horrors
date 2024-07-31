class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoice = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.invoices.find(params[:id])
  end

end