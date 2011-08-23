module ApplicationHelper

  def link_to_gopay(text, order, options = {})
    payment = GoPay::Payment.new(:payment_session_id => order.payment_session_id)
    parameters = {"sessionInfo.eshopGoId" => GoPay.configuration.goid,
                  "sessionInfo.paymentSessionId" => order.payment_session_id,
                  "sessionInfo.encryptedSignature" => GoPay::Crypt.encrypt(payment.concat_for_check)
    }
    query_string = parameters.map { |key, value| "#{key}=#{value}" }.join("&")
    url = GoPay.configuration.urls["full_integration"] + "?" + query_string
    link_to(text, url, options).html_safe
  end
end
