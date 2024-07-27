class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
    @top_customers = @merchant.top_customers
  end
end