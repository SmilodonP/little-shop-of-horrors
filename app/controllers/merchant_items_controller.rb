class MerchantItemsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @merchant_item = merchant.item.find(params[:id])
  end
end
