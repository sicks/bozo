class Map < ActiveRecord::Base
  belongs_to :corp
  belongs_to :home, class_name: "System", foreign_key: "home_id"

  validates_presence_of :corp, :title, :home
  validates :home, inclusion: { in: System.all, message: "must be a system that exists" }

  def home_node
    { id: home.id, label: home.name, shape: home.shape, size: home.size, color: home.color }
  end

  def nodes
    # for each system, do what you did up there
  end

  def edges
    # for each connection ''
  end
end
