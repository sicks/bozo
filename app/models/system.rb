class System < ActiveRecord::Base
  has_one :system_bonus, primary_key: :ccp_id, foreign_key: :ccp_id, inverse_of: :system

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
      if sec_status > 0.5
        '#008E09'
      elsif sec_status < 0.5 && sec_status > 0.0
        '#FFBF00'
      else
        '#FF0303'
      end
    else
      unless system_bonus.nil?
        case system_bonus.anomaly
        when "Cataclysmic Variable"
          '#76C2D9'
        when "Magnetar"
          '#FC9D00'
        when "Pulsar"
          '#6CB662'
        when "Wolf Rayet"
          '#A777EB'
        when "Black Hole"
          '#848F95'
        when "Red Giant"
          '#F38596'
        end
      else
        '#DCDCDC'
      end
    end
  end

  def is_kspace?
    system_class == 7 || system_class == 9
  end
end
