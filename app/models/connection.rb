class Connection < ActiveRecord::Base
  belongs_to :map, touch: true
  belongs_to :from, class: System
  belongs_to :to, class: System
  belongs_to :hole

  validates_presence_of :map, :from, :to, :hole, :stage
  validates :eol, inclusion: { in: [true, false] }
  validates :hole, inclusion: { in: Hole.all, message: "must be a Hole that exists" }

  def edge
    { id: id, from: from_id, to: to_id, label: hole.name, dashes: dashes, color: color, value: hole.width }
  end

  def color
    case stage
    when 1
      "#5EBC41"
    when 2
      "#BBB628"
    when 3
      "#BB2828"
    end
  end

  def dashes
    eol? ? [5,15] : false
  end
end
