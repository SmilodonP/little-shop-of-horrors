class Admin::MerchantsController < ApplicationController 
  def index
    @merchants = Merchant.all
    @top_five_merchants = Merchant.top_five_merchants

    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:status]
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path, notice: "The merchant has been #{@merchant.status}."
    else
      @merchant.update!(name: params[:merchant][:name])
      redirect_to admin_merchant_path(@merchant), notice: "GREAT SUCCESS!"
    end
  end

  def new
    
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to admin_merchants_path
    else
      redirect_to new_admin_merchant_path
      flash[:alert] = "Error: Enter a name, unkay!"
    end
  end 

  private
    def merchant_params
      params.permit(:name)
    end
end
