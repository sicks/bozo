class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :database_authenticatable, :recoverable, :validatable
  devise :registerable, :rememberable, :trackable
  devise :omniauthable, omniauth_providers: [:crest]

  has_many :chars, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :chars
  validates_associated :chars

  def self.from_omniauth( auth_hash )
    user = joins(:chars).where("chars.provider = ? AND chars.uid = ?", auth_hash.provider.to_s, auth_hash.uid.to_s).first_or_create do |u|
      char = Char.new( provider: auth_hash.provider.to_s,
                         uid: auth_hash.uid.to_s,
                         name: auth_hash.info.name,
                         owner: auth_hash.info.character_owner_hash)
      u.chars << char
    end
  end

  def name
    self.chars.any? ? self.chars.first.name : "raaaaaaaaaaaaaaaandy"
  end
end
