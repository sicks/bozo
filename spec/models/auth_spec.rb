require 'rails_helper'

RSpec.describe 'Unit Tests for: app/models/auths.rb', type: :model do
  let(:steam_auth) { create(:steam_auth) }
  let(:google_auth) { create(:google_auth) }
  let(:all_auths) { Auth.all }

  describe Auth, 'scopes' do
    specify 'default: oldest to newest' do
      google_auth
      expect( all_auths.first.created_at ).to be < all_auths.last.created_at
    end
  end

  describe Auth, 'validates' do
    %w[uid provider user].each do |attribute|
      specify "presence of #{attribute}" do
        setter = attribute + "="
        steam_auth.send setter.to_sym, nil
        expect( steam_auth.valid? ).to eq false
      end
    end
  end

  describe Auth, "methods" do
    describe "#name" do
      it "returns the provider name up to the first underscore" do
        expect( google_auth.name ).to eq "google"
      end
    end
  end
end
