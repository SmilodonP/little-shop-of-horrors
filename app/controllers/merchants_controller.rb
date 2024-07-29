class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
  end
end