class Map < ActiveRecord::Base
  belongs_to :corp
  belongs_to :home, class_name: "System", foreign_key: "home_id"

  validates_presence_of :corp, :title, :home
  validates :home, inclusion: { in: System.all, message: "must be a system that exists" }
end
