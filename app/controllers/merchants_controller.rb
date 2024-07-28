class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def index
    @merchant = Merchant.all
  end

  def items_index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end
end