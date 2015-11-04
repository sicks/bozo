require 'rails_helper'

RSpec.describe 'Unit Tests for: app/models/auths.rb', type: :model do
  let(:auth) { create(:steam_auth) }
  let(:another) { create(:google_auth) }
  let(:all) { Auth.all }

  describe Auth, 'scopes' do
    specify 'default: oldest to newest' do
      another
      expect( all.first.created_at ).to be < all.last.created_at
    end
  end

  describe Auth, 'validates' do
    %w[uid provider user].each do |attribute|
      specify "presence of #{attribute}" do
        setter = attribute + "="
        auth.send setter.to_sym, nil
        expect( auth.valid? ).to eq false
      end
    end
  end
end
