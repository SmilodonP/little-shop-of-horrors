class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def index
    @merchant = Merchant.all
  end

end