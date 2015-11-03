class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :database_authenticatable, :recoverable, :validatable
  devise :registerable, :rememberable, :trackable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :steam]

  has_many :auths
  validates_associated :auths
end
