class SystemJump < ActiveRecord::Base
  has_one :from_system, class_name: "System", primary_key: :from_ccp_id, foreign_key: :ccp_id
  has_one :neighboring_system, class_name: "System", primary_key: :to_ccp_id, foreign_key: :ccp_id
end
