class Auth < ActiveRecord::Base
  belongs_to :user
  validates :uid, :provider, :user_id, presence: true
  default_scope { order( created_at: :asc ) }
end
