class Auth < ActiveRecord::Base
  default_scope { order( created_at: :asc ) }

  belongs_to :user, inverse_of: :auths

  validates :uid, :provider, :user, presence: true
end
