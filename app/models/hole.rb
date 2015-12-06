class Hole < ActiveRecord::Base

  def width
    case jumpable
    when 5000000
      return 1
    when 20000000
      return 2
    when 300000000
      return 3
    when 1000000000
      return 4
    when 1350000000, 1800000000
      return 5
    end
  end

end
