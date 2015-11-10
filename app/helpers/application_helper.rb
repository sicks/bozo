module ApplicationHelper
  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def eve_image_tag( type, id, width=64 )
    ext = ( type == :character ? "jpg":"png" )
    tag "img", { src: "https://image.eveonline.com/#{type.to_s.humanize}/#{id}_#{width}.#{ext}" }
  end
end
