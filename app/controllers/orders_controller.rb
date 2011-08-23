class OrdersController < ApplicationController

  def index
    @payment_methods = GoPay::PaymentMethod.all
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])
    if @order.save and @order.save_on_gopay
      @order.submit
      flash[:notice] = "Vytvoreno!"
      redirect_to :action => :index
    else
      flash[:error] = "NEvytvoreno!"
      render :action => :index
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    flash[:notice] = "Smazáno!"
    redirect_to :action => :index
  end

end