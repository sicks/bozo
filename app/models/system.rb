class System < ActiveRecord::Base
  has_one :system_bonus, primary_key: :ccp_id, foreign_key: :ccp_id, inverse_of: :system

  def node
    { id: id, label: name, shape: shape, color: { background: color, border: border }, borderWidth: width }
  end

  def shape
    if is_kspace?
      'ellipse'
    else
      'circle'
    end
  end

  def size
    if is_kspace?
      4
    else
      system_class
    end
  end

  def color
    if is_kspace?
      if sec_status >= 0.5
        '#6CB662'
      elsif sec_status < 0.5 && sec_status > 0.0
        '#FFDD8B'
      else
        '#F85156'
      end
    else
      case system_class
      when 1
        "#6CB662"
      when 2
        "#76C2D9"
      when 3
        "#FFDD8B"
      when 4
        "#A672A6"
      when 5
        "#F38596"
      when 6
        "#F85156"
      end
    end
  end

  def border
    unless system_bonus.nil?
      case system_bonus.anomaly
        when "Cataclysmic Variable"
          '#F3C530'
        when "Magnetar"
          '#6DD627'
        when "Pulsar"
          '#3F5CBF'
        when "Wolf Rayet"
          '#F39413'
        when "Black Hole"
          '#131D3F'
        when "Red Giant"
          '#D9200A'
        end
    else
      '#DCDCDC'
    end
  end

  def width
    if system_bonus.nil?
      2
    else
      6
    end
  end

  def is_kspace?
    system_class == 7 || system_class == 9
  end
end
