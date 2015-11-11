class AddStaticAssets < ActiveRecord::Migration
  def change
    create_table "holes" do |t|
      t.string   "name"
      t.string   "destination"
      t.boolean  "regen"
      t.integer  "lifespan"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "mass",        limit: 8
      t.integer  "jumpable",    limit: 8
      t.boolean  "static"
    end

    create_table "system_bonus" do |t|
      t.integer  "ccp_id"
      t.string   "anomaly"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "system_jumps" do |t|
      t.integer  "from_ccp_id"
      t.integer  "to_ccp_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "systems" do |t|
      t.string   "name"
      t.integer  "ccp_id"
      t.float    "sec_status"
      t.integer  "system_class"
      t.string   "region"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "wormhole_effects" do |t|
      t.float    "modifier"
      t.string   "affected"
      t.string   "anomaly"
      t.integer  "system_class"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
