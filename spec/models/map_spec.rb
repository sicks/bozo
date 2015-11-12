require 'rails_helper'

RSpec.describe "Unit Tests for app/models/map.rb", type: :model do
  let(:map) { create(:map) }

  describe Map, "validates" do
    %w[corp title home].each do |attribute|
      specify "presence of #{attribute}" do
        setter = attribute + "="
        map.send setter.to_sym, nil
        expect( map.valid? ).to eq false
      end
    end

    specify "inclusion of home in systems list" do
      map.home_id = 99999999
      expect( map.valid? ).to eq false
    end
  end
end
