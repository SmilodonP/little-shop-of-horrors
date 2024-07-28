class Dashboard < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @top_customers = @merchant.top_customers
  end
end