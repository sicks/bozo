class Char < ActiveRecord::Base
  default_scope { order( created_at: :asc ) }

  belongs_to :user, inverse_of: :chars

  validates_presence_of :uid, :provider, :user, :name
  validates_uniqueness_of :uid, :name

  def corp
    eaal.scope = "eve"
    corp_id = eaal.CharacterInfo( characterID: uid ).corporationID
    corp_name = eaal.CharacterInfo( characterID: uid ).corporation
    Corp.where(name: corp_name, ccp_id: corp_id).first_or_create
  end

  private
  def eaal
    EAAL.cache = EAAL::Cache::FileCache.new
    @api ||= EAAL::API.new
  end
end
