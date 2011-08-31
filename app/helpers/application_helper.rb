module ApplicationHelper

  def link_to_gopay(text, order, options = {})
    link_to(text, order.gopay_url, options).html_safe
  end

end
