class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
    @top_customers = @merchant.top_customers
    @items_ready_to_ship = @merchant.items_ready_to_ship
  end

end