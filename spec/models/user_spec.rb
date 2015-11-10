require 'rails_helper'

RSpec.describe 'Unit Tests for: app/models/user.rb', type: :model do
  let!(:user) { create(:user_sicks) }
  let(:auth_hash) { OmniAuth::AuthHash.new({
      provider: "crest",
      uid: 924610593,
      info: {
        name: "Sicks",
        character_id: 924610593,
        expires_on: "2015-11-09T21:43:59",
        scopes: "",
        token_type: "Character",
        character_owner_hash: "5ZQrqrBJh/Yu6/mdu9GugC549K4="
      },
      credentials: {
        token: "ydt7_3FQ-YtygaHd5sQ1kfwEframi_w7p4jmNaab9IWFYc4Fzs3q4jIbp8XDismmEJE_1Wc2STdzMqhvgBNQdQ2",
        expires_at: 1447105439,
        expires: true
      },
      extra: {
        raw_info: {
          "CharacterID"=> 924610593,
          "CharacterName"=> "Sicks",
          "ExpiresOn"=> "2015-11-09T21:43:59",
          "Scopes"=> "",
          "TokenType"=> "Character",
          "CharacterOwnerHash"=> "5ZQrqrBJh/Yu6/mdu9GugC549K4="
        }
      }
    })
  }

  describe User,'validates' do
    specify 'validity of chars' do
      user.chars.first.provider = nil
      expect( user.valid? ).to eq false
    end
  end

  describe User, "methods" do
    describe "::from_omniauth( auth_hash )" do
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

        it "returns a newly created user" do
          expect( new_user ).to be_a( User )
          expect( new_user.persisted? ).to eq true
        end
      end
    end

    describe "#name" do
      let(:name) { user.chars.first.name }

      specify "returns the name of this user's first character" do
        expect( user.name ).to eq name
      end
    end
  end
end
