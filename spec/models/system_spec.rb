require 'rails_helper'

RSpec.describe "Unit Tests for app/models/system.rb", type: :model do
  let(:c1_cataclysmic) { System.find(7168) }
  let(:c2_magnetar) { System.find(7444) }
  let(:c3_pulsar) { System.find(240) }
  let(:c4_wolf_rayet) { System.find(728) }
  let(:c5_black_hole) { System.find(1233) }
  let(:c6_red_giant) { System.find(1729) }
  let(:lowsec_system) { System.find_by_name("Decon") }
  let(:highsec_system) { System.find_by_name("Amarr") }
  let(:nullsec_system) { System.find_by_name("G-5EN2") }

  describe System, "methods" do
    describe "#node" do
      it "returns node data for vis" do
        match_json_schema('node', c1_cataclysmic.node)
      end
    end

    describe "#shape" do
      context "when kspace" do
        it "returns 'ellipse'" do
          expect( lowsec_system.shape ).to eq 'ellipse'
        end
      end
      context "when wspace" do
        it "returns 'box'" do
          expect( c5_black_hole.shape ).to eq 'box'
        end
      end
    end

    describe "#color" do
      it "returns background color based on system class" do
        expect( highsec_system.color ).to eq '#54A082'
        expect( lowsec_system.color ).to eq '#F27435'
        expect( nullsec_system.color ).to eq '#991818'
        expect( c1_cataclysmic.color ).to eq '#54A082'
        expect( c2_magnetar.color ).to eq '#586ABA'
        expect( c3_pulsar.color ).to eq '#A68C69'
        expect( c4_wolf_rayet.color ).to eq '#472F5F'
        expect( c5_black_hole.color ).to eq '#F63700'
        expect( c6_red_giant.color ).to eq '#991818'
      end
    end

    describe "#border" do
      it "returns border color based on system bonus" do
        expect( c1_cataclysmic.border ).to eq '#F3C530'
        expect( c2_magnetar.border ).to eq '#6DD627'
        expect( c3_pulsar.border ).to eq '#9DD3DF'
        expect( c4_wolf_rayet.border ).to eq '#F39413'
        expect( c5_black_hole.border ).to eq '#131D3F'
        expect( c6_red_giant.border ).to eq '#D9200A'
        expect( lowsec_system.border ).to eq '#DCDCDC'
      end
    end

    describe "#width" do
      it "returns 6 or 2 if system is bonused or not" do
        expect( c1_cataclysmic.width ).to eq 6
        expect( highsec_system.width ).to eq 2
      end
    end

    describe "#is_kspace?" do
      it "returns true or false if system is kspace or not" do
        expect( highsec_system.is_kspace? ).to eq true
        expect( c1_cataclysmic.is_kspace? ).to eq false
      end
    end

    describe "#human_class" do
      it "returns a human friendly system class descriptor" do
        expect( c1_cataclysmic.human_class ).to eq "Class 1"
        expect( c2_magnetar.human_class ).to eq "Class 2"
        expect( c3_pulsar.human_class ).to eq "Class 3"
        expect( c4_wolf_rayet.human_class ).to eq "Class 4"
        expect( c5_black_hole.human_class ).to eq "Class 5"
        expect( c6_red_giant.human_class ).to eq "Class 6"
        expect( highsec_system.human_class ).to eq "High Sec"
        expect( lowsec_system.human_class ).to eq "Low Sec"
        expect( nullsec_system.human_class ).to eq "Null Sec"
      end
    end
  end
end
