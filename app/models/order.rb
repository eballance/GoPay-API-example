class Order < ActiveRecord::Base

    include AASM

  aasm_column :state
  aasm_initial_state :new
  aasm_state :new
  aasm_state :waiting
  aasm_state :payment_done
  aasm_state :timeouted
  aasm_state :canceled

  aasm_event :submit do
    transitions :to => :waiting, :from => [:new]
  end

  aasm_event :cancel do
    transitions :to => :canceled, :from => [:waiting]
  end

  aasm_event :timeout do
    transitions :to => :timeouted, :from => [:waiting]
  end

  aasm_event :pay do
    transitions :to => :payment_done, :from => [:waiting]
  end
    
  def save_on_gopay
    payment = GoPay::EshopPayment.new(:variable_symbol => "gopay_test_#{GoPay.configuration.goid}",
                                      :total_price_in_cents => price.to_i,
                                      :product_name => name,
                                      :payment_channel => payment_method_code
    ).create
    self.payment_session_id = payment.payment_session_id
    save!
  end

  def actual_state
    payment = GoPay::EshopPayment.new(:variable_symbol => "gopay_test_#{GoPay.configuration.goid}",
                                      :total_price_in_cents => price.to_i,
                                      :product_name => name,
                                      :payment_session_id => payment_session_id,
                                      :payment_channels => ["cz_gp_w"])
    payment.actual_session_state
  end
end
