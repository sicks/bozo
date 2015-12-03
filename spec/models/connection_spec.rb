require 'rails_helper'

RSpec.describe 'Unit Tests for: app/models/connection.rb', type: :model do
  let(:connection) { create(:direct_lowsec_connection) }

  describe Connection, "validates" do
    %w[map from to hole stage].each do |attribute|
      specify "presence of #{attribute}" do
        setter = attribute + "="
        connection.send setter.to_sym, nil
        expect( connection.valid? ).to eq false
      end
    end

    specify "presence of eol" do
       connection.eol = nil
       expect( connection.valid? ).to eq false
    end

    specify "inclusion of hole in holes list" do
      connection.hole_id = 99999999
      expect( connection.valid? ).to eq false
    end
  end

  describe Connection, "methods" do

    describe "#edge" do
      it "returns edge data for vis" do
        match_json_schema('edge', connection.edge, strict: true)
      end
    end

    describe "#color" do
      context "when stage 1" do
        let(:connection) { create(:direct_lowsec_connection, stage: 1) }
        it "returns green" do
          expect( connection.color ).to eq "#5EBC41"
        end
      end
      context "when stage 2" do
        let(:connection) { create(:direct_lowsec_connection, stage: 2) }
        it "returns yellow" do
          expect( connection.color ).to eq "#BBB628"
        end
      end
      context "when stage 3" do
        let(:connection) { create(:direct_lowsec_connection, stage: 3) }
        it "returns red" do
          expect( connection.color ).to eq "#BB2828"
        end
      end
    end

    describe "#dashes" do
      context "when fresh" do
        it "returns false" do
          expect( connection.dashes ).to eq false
        end
      end

      context "when eol" do
        let(:connection) { create(:direct_lowsec_connection, eol: true) }
        it "returns [5, 15]" do
          expect( connection.dashes ).to eq [5, 15]
        end
      end
    end
  end
end
