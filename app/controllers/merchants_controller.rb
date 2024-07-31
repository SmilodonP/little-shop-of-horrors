class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
    @items_ready_to_ship = @merchant.items_ready_to_ship
  end
  
  def index
    @merchant = Merchant.all
  end
end