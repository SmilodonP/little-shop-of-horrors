class Admin::MerchantsController < ApplicationController 
  def index
    @merchants = Merchant.all
    @top_five_merchants = Merchant.top_five_merchants 
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  #ENABLED/DISABLED MERCHANT LOGIC SHOULD BE IN THE CONTROLLER NOT THE VIEW


# user story 27 fails
  # def update
  #   @merchant = Merchant.find(params[:id])
  #   if @merchant.update(name: params[:name])
  #     redirect_to admin_merchant_path(@merchant), notice: "GREAT SUCCESS!"
  #   elsif params[:status] #moved this above so that it can correctly enable merchants? Seems strange
  #     @merchant.update(status: params[:status])
  #     redirect_to admin_merchants_path, notice: "The merchant has been #{@merchant.status}."
  #   else   
  #     render :edit
  #   end
  # end


  #user story 26 fails
  def update
    @merchant = Merchant.find(params[:id])
    if params[:status] #moved this above so that it can correctly enable merchants? Seems strange
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path, notice: "The merchant has been #{@merchant.status}."
    elsif
      @merchant.update(name: params[:name])
      redirect_to admin_merchant_path(@merchant), notice: "GREAT SUCCESS!"
    else   
      render :edit
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
