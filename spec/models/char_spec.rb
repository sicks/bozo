require 'rails_helper'

RSpec.describe 'Unit Tests for: app/models/char.rb', type: :model do
  let(:crest_char) { create(:crest_char) }
  let(:another_char) { create(:crest_char) }
  let(:all_auths) { Char.all }

  describe Char, 'scopes' do
    specify 'default: oldest to newest' do
      another_char
      expect( all_auths.first.created_at ).to be < all_auths.last.created_at
    end
  end

  describe Char, 'validates' do
    %w[uid provider user ccp_id name].each do |attribute|
      specify "presence of #{attribute}" do
        setter = attribute + "="
        crest_char.send setter.to_sym, nil
        expect( crest_char.valid? ).to eq false
      end
    end
  end
end
