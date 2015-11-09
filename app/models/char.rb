class Char < ActiveRecord::Base
  default_scope { order( created_at: :asc ) }

  belongs_to :user, inverse_of: :chars

  validates_presence_of :uid, :provider, :user, :ccp_id, :name
  validates_uniqueness_of :uid, :ccp_id, :name
end
