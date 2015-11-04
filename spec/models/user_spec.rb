require 'rails_helper'

RSpec.describe 'app/models/user.rb', type: :model do
  let!(:user) { create(:user) }
  let(:auth_hash) { OmniAuth::AuthHash.new( attributes_for :steam_auth ) }

  describe User,'validates' do
    %w[username].each do |attribute|
      specify "presence of #{attribute}" do
        setter = attribute + "="
        user.send setter.to_sym, nil
        expect( user.valid? ).to eq false
      end
    end

    specify "uniqueness of username" do
      expect( user.dup.valid? ).to eq false
    end

    specify 'validity of auths' do
      user.auths.first.provider = nil
      expect( user.valid? ).to eq false
    end
  end

  describe User, "class methods" do
    describe ".from_omniauth( auth_hash )" do
      let(:new_user) { User.from_omniauth( auth_hash ) }

      context "when this user's already registered" do
        before(:example) do
          user
        end

        it "returns the registered user" do
          expect( new_user ).to eq user
        end
      end

      context "when this user doesn't exist yet" do
        before(:example) do
          User.destroy_all
        end

        it "returns false" do
          expect( new_user ).to eq false
        end
      end
    end
  end
end
