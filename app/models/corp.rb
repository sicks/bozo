class Corp < ActiveRecord::Base
  validates_presence_of :ccp_id, :name
  validates_uniqueness_of :ccp_id, :name
end
