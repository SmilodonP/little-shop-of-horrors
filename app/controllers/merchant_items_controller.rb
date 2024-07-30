class MerchantItemsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_item = @merchant.items.find(params[:id])
  end
end
