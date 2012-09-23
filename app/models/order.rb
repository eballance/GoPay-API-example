class Order < ActiveRecord::Base

  include AASM

  aasm_column :state
  aasm_initial_state :new
  aasm_state :new
  aasm_state :created
  aasm_state :paid
  aasm_state :timeouted
  aasm_state :canceled

  aasm_event :submit do
    transitions :to => :created, :from => [:new]
  end

  aasm_event :cancel do
    transitions :to => :canceled, :from => [:created]
  end

  aasm_event :timeout do
    transitions :to => :timeouted, :from => [:created]
  end

  aasm_event :pay do
    transitions :to => :paid, :from => [:created]
  end

  def save_on_gopay
    payment = GoPay::BasePayment.new(:order_number => "order-#{id}",
                                     :product_name => name,
                                     :total_price_in_cents => price.to_i,
                                     :default_payment_channel => "cz_vb",
                                     :currency => currency,
                                     :email => 'patrikjira@gmail.com')
    payment.create
    self.payment_session_id = payment.payment_session_id
    save!
  end

  def payment
    p = GoPay::BasePayment.new(:order_number => "order-#{id}",
                               :total_price_in_cents => price.to_i,
                               :product_name => name,
                               :currency => currency,
                               :payment_session_id => payment_session_id,
                               :payment_channels => [],
                               :email => 'patrikjira@gmail.com')
    p.load
    p
  end

  def payment_attrs
    response = payment.response
    ppayment_chanel = response[:payment_channel].is_a?(Hash) ? "" : payment.last_response[:payment_channel]
    {:payment_channel => ppayment_chanel,
     :session_state => response[:session_state]}
  end

  def gopay_url
    GoPay::Payment.new(:payment_session_id => payment_session_id).gopay_url
  end

end
