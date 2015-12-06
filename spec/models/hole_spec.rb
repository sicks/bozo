require 'rails_helper'

RSpec.describe 'Unit Tests for: app/models/hole.rb', type: :model do
  let(:hole) { Hole.first }

  describe Hole, "methods" do
    describe "#width" do
      %w[5000000 20000000 300000000 1000000000 1350000000].each_with_index do |size, key|
        specify "returns #{key+1} for #{size}t wormholes" do
          hole.jumpable = size
          expect( hole.width ).to eq key+1
        end
      end
      specify "returns 5 for 1800000000t wormholes" do
        hole.jumpable = 1800000000
        expect( hole.width ). to eq 5
      end
    end
  end

end
