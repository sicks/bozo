class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :database_authenticatable, :recoverable, :validatable
  devise :registerable, :rememberable, :trackable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :steam]

  validates :username, presence: true, uniqueness: true

  has_many :auths, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :auths
  validates_associated :auths

  def self.from_omniauth( auth_hash )
    user = joins(:auths).where("auths.provider = ? AND auths.uid = ?", auth_hash.provider, auth_hash.uid).first
    user.nil? ? false : user
  end
end
