require 'rails_helper'

RSpec.describe 'Unit Tests for app/models/corp.rb', type: :model do
  let(:corp) { create(:corp_iso) }

  describe Corp, 'validates' do
    %w[ccp_id name].each do |attribute|
      specify "presence of #{attribute}" do
        setter = attribute + "="
        corp.send setter.to_sym, nil
        expect( corp.valid? ).to eq false
      end

      specify "uniqueness of #{attribute}" do
        another_corp = build(:corp_dg3n)
        setter = attribute + "="
        another_corp.send( setter.to_sym, corp.send( attribute.to_sym ) )
        expect( another_corp.valid? ).to eq false
      end
    end
  end

  describe Corp, 'methods' do
    describe "#image_url" do
      it "returns CCP image server corp logo url" do
        expect( corp.image_url(64) ).to eq "https://image.eveonline.com/Corporation/#{corp.ccp_id}_64.png"
      end
    end
  end
end
