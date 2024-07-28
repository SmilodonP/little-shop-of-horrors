class Admin::MerchantsController < ApplicationController 
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])

    if @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant), notice: "GREAT SUCCESS!"
    elsif @merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    else   
      render :edit
    end
  end

    private

    def merchant_params
      params.require(:merchant).permit(:name)
    end
end