class Map < ActiveRecord::Base
  belongs_to :corp
  belongs_to :home, class_name: "System", foreign_key: "home_id"
end
