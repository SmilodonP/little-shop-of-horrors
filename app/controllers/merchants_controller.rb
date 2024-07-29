class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
    @items_ready_to_ship = @merchant.items_ready_to_ship
  end
  
  def index
    @merchant = Merchant.all
  end

    # I think this should become a items controller
  def items_index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end
end