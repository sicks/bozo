require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let(:auth_hash) { OmniAuth::AuthHash.new( attributes_for :steam_auth ) }

  it 'has a valid factory' do
    expect( user.valid? ).to eq true
  end

  it 'is invalid with invalid auths' do
    user.auths.first.provider = nil
    expect( user.valid? ).to eq false
  end

  describe ".from_omniauth" do
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
