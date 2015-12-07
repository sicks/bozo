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

    specify "validity of connections" do
      map.connections.create( attributes_for(:direct_lowsec_connection) )
      map.connections.first.to = nil
      expect( map.valid? ).to eq false
    end
  end

  describe Map, "methods" do
    before(:each) do
      map.connections.create( attributes_for(:direct_lowsec_connection) )
    end

    describe "#home_node" do
      it "returns home system node data for vis" do
        match_json_schema('node', map.home_node)
      end
    end

    describe "#nodes" do
      it "returns an array" do
        expect( map.nodes ).to be_kind_of(Array)
      end
      specify "starting with the home node" do
        expect( map.nodes[0] ).to eq map.home_node
      end
      specify "followed by node data for vis" do
        match_json_schema('node', map.nodes[1])
      end
    end

    describe "#edges" do
      it "returns an array" do
        expect( map.edges ).to be_kind_of(Array)
      end
      specify "containing edge data for vis" do
        match_json_schema('edge', map.edges[0])
      end
    end

    describe "#systems" do
      let(:systems) {
        ids = []
        ids << map.home.id
        ids << attributes_for(:direct_lowsec_connection)[:from].id
        ids << attributes_for(:direct_lowsec_connection)[:to].id
        System.where(id: ids)
      }
      it "returns a collection of Systems" do
        expect( map.systems ).to be_kind_of(ActiveRecord::Relation)
      end
      specify "containing the home system, and those from connections" do
        expect( map.systems ).to match_array(systems)
      end
    end

    describe "#layout" do
      let(:layout_data) {
        {"676"=>{"x"=>266, "y"=>-269}, "1082"=>{"x"=>259, "y"=>-439}, "1317"=>{"x"=>408, "y"=>-497}}
      }
      context "when there's no layout" do
        specify "returns nil" do
          expect( map.layout ).to be nil
        end
      end
      context "when a layout has been saved" do
        specify "returns positional data for vis" do
          map.layout = layout_data.to_json
          match_json_schema('layout', layout_data.to_json, strict: true)
        end
      end
    end

    describe "#as_json" do
      it "returns updated_at as an integer" do
        expect( map.as_json["updated_at"] ).to be_kind_of(Integer)
      end
    end
  end
end
