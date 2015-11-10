require 'rails_helper'

RSpec.describe 'Unit Tests for: app/models/char.rb', type: :model do
  let(:char) { create(:char) }
  let(:another_char) { create(:char) }
  let(:all_auths) { Char.all }

  describe Char, 'scopes' do
    specify 'default: oldest to newest' do
      another_char
      expect( all_auths.first.created_at ).to be < all_auths.last.created_at
    end
  end

  describe Char, 'validates' do
    %w[uid provider user name].each do |attribute|
      specify "presence of #{attribute}" do
        setter = attribute + "="
        char.send setter.to_sym, nil
        expect( char.valid? ).to eq false
      end
    end
  end

  describe Char, 'methods' do
    describe "#corp" do
      it "returns this character's current corp" do
        sicks = create(:char_sicks)
        expect( sicks.corp ).to be_a( Corp )
      end
    end

    describe "(#eaal)" do
      let!(:api) { char.send(:eaal) }
      it "sets up an eaal cache" do
        expect( EAAL.cache ).to be_a( EAAL::Cache::FileCache )
      end
      it "returns an api object" do
        expect( api ).to be_a( EAAL::API )
      end
    end
  end
end
