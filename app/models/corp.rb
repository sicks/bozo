class Corp < ActiveRecord::Base
  validates_presence_of :ccp_id, :name
  validates_uniqueness_of :ccp_id, :name

  has_many :maps

  def image_url( size )
    "https://image.eveonline.com/Corporation/#{ccp_id}_#{size}.png"
  end
end
