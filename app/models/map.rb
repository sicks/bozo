class Map < ActiveRecord::Base
  default_scope { includes(:connections) }
  serialize :layout
  belongs_to :corp
  belongs_to :home, class_name: "System", foreign_key: "home_id"
  has_many :connections
  accepts_nested_attributes_for :connections

  validates_presence_of :corp, :title, :home
  validates :home, inclusion: { in: System.all, message: "must be a system that exists" }
  validates_associated :connections

  def home_node
    { id: home.id, label: title, shape: 'circularImage', image: corp.image_url(128), size: 40, mass: 1 }
  end

  def nodes
    list = []
    list << home_node
    connections.each do |c|
      list << c.from.node if c.from != home
      list << c.to.node if c.to != home
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

  def systems
    list = []
    connections.each do |c|
      list << c.from_id
      list << c.to_id
    end
    System.where(id: list)
  end

  def layout
    JSON.parse( read_attribute(:layout) )
  end
end
