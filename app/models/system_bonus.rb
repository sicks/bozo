class SystemBonus < ActiveRecord::Base
  belongs_to :system, primary_key: :ccp_id, foreign_key: :ccp_id, inverse_of: :system_bonus
end
