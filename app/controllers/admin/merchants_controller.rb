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
    
    if params[:status] #moved this above so that it can correctly enable merchants? Seems strange
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path, notice: "The merchant has been #{@merchant.status}."
    elsif @merchant.update(name: params[:name])
      redirect_to admin_merchant_path(@merchant), notice: "GREAT SUCCESS!"
    else   
      render :edit
    end

    # if @merchant.update(merchant_params)
    #   redirect_to admin_merchant_path(@merchant), notice: "GREAT SUCCESS!"
    # elsif @merchant.update(status: params[:status])
    #   redirect_to admin_merchants_path
    # else   
    #   render :edit
    # end
  end
end
