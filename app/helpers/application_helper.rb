module ApplicationHelper
  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def render_flash
    output = ""
    flash.each do |type, message|
      output << content_tag( :div, message, class: "#{type} label" )
    end
    output.html_safe
  end
end
