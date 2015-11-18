class System < ActiveRecord::Base
  has_one :system_bonus, primary_key: :ccp_id, foreign_key: :ccp_id, inverse_of: :system

  def node
    {
      id: id,
      label: name,
      shape: shape,
      color: {
        background: color,
        border: border,
        highlight: {
          background: color,
          border: border }
      },
      borderWidth: width,
      borderWidthSelected: width
    }
  end

  def shape
    if is_kspace?
      'ellipse'
    else
      'circle'
    end
  end

  def color
    if is_kspace?
      if sec_status >= 0.5
        '#54A082'
      elsif sec_status < 0.5 && sec_status > 0.0
        '#F27435'
      else
        '#991818'
      end
    else
      case system_class
      when 1
        "#54A082"
      when 2
        "#586ABA"
      when 3
        "#A68C69"
      when 4
        "#472F5F"
      when 5
        "#F63700"
      when 6
        "#991818"
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
          '#9DD3DF'
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

  def human_class
    if is_kspace?
      if sec_status >= 0.5
        'High Sec'
      elsif sec_status < 0.5 && sec_status > 0.0
        'Low Sec'
      else
        'Null Sec'
      end
    else
      "Class #{system_class}"
    end
  end
end
