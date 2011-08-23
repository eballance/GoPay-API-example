class Order < ActiveRecord::Base

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
