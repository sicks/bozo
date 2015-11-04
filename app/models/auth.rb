class Auth < ActiveRecord::Base
  belongs_to :user, inverse_of: :auths
  validates :uid, :provider, :user, presence: true
  default_scope { order( created_at: :asc ) }
end
