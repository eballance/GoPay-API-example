class OrdersController < ApplicationController

  before_filter :check_identity, :only => [:notification, :success, :failed]

  def index
    @payment_methods = GoPay::PaymentMethod.all
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])
    if @order.save and @order.save_on_gopay
      flash[:notice] = "Vytvoreno!"
      @order.submit!
      if params[:redirect_to_gopay] and params[:redirect_to_gopay] == "1"
        redirect_to @order.gopay_url
      else
        redirect_to :action => :index
      end
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

  def notification
    process_order
    render :template => "orders/notification"
  end

  def success
    flash[:notice] = "Vše v pořádku."
    process_order
    render :template => "orders/notification"
  end

  def failed
    flash[:error] = "Tu se něco rozbilo!"
    process_order
    render :template => "orders/notification"
  end

  private
  def check_identity
    payment_identity = PaymentIdentity.new(:goid => params[:eshopGoId],
                                           :variable_symbol => params[:variableSymbol],
                                           :payment_session_id => params[:paymentSessionId])
    if !payment_identity.valid_for_signature?(params[:encryptedSignature])
      flash[:error] = "Platba #{params[:paymentSessionId]} byla podvržena!"
      redirect_to root_path
    end
  end

  def process_order
    order = Order.find_by_payment_session_id(params[:paymentSessionId])
    case order.payment_attrs[:session_state]
      when GoPay::PAYMENT_DONE
        order.pay! unless order.payment_done?
      when GoPay::TIMEOUTED
        order.timeout! unless order.timeouted?
      when GoPay::CANCELED
        order.cancel! unless order.canceled?
    end
  end

end
