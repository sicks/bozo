class Connection < ActiveRecord::Base
  belongs_to :map, touch: true
  belongs_to :from, class: System
  belongs_to :to, class: System
  belongs_to :hole

  def edge
    { id: id, from: from_id, to: to_id, label: hole.name, dashes: dashes, color: color, value: width }
  end

  def width
    1
    if hole.jumpable > 5000000 && hole.jumpable <= 20000000
      2
    elsif hole.jumpable > 20000000 && hole.jumpable <= 300000000
      3
    elsif hole.jumpable > 300000000 && hole.jumpable <= 1000000000
      4
    elsif hole.jumpable > 1000000000 && hole.jumpable <= 1350000000
      5
    elsif hole.jumpable > 1350000000
      6
    end
  end

  def color
    case stage
    when 1
      "#6CB662"
    when 2
      "#FFDD8B"
    when 3
      "#F85156"
    end
  end

  def dashes
    eol? ? [5,15] : false
  end
end
