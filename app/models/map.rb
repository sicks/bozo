class Map < ActiveRecord::Base
  belongs_to :corp
  belongs_to :home, class_name: "System", foreign_key: "home_id"
  has_many :connections
  accepts_nested_attributes_for :connections

  validates_presence_of :corp, :title, :home
  validates :home, inclusion: { in: System.all, message: "must be a system that exists" }
  validates_associated :connections

  def nodes
    list = []
    connections.each do |c|
      list << c.from.node
      list << c.to.node
    end
    list.uniq
  end

  def edges
    list = []
    connections.each do |c|
      list << c.edge
    end
    list.uniq
  end
end
