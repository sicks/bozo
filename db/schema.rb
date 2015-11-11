# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151110224812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chars", force: :cascade do |t|
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "name",       default: "", null: false
    t.string   "owner",      default: "", null: false
    t.integer  "uid",        default: 0,  null: false
  end

  add_index "chars", ["provider"], name: "index_chars_on_provider", using: :btree

  create_table "corps", force: :cascade do |t|
    t.string   "name"
    t.integer  "ccp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holes", force: :cascade do |t|
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

  create_table "maps", force: :cascade do |t|
    t.integer  "corp_id"
    t.string   "title"
    t.integer  "home_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_bonus", force: :cascade do |t|
    t.integer  "ccp_id"
    t.string   "anomaly"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_jumps", force: :cascade do |t|
    t.integer  "from_ccp_id"
    t.integer  "to_ccp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", force: :cascade do |t|
    t.string   "name"
    t.integer  "ccp_id"
    t.float    "sec_status"
    t.integer  "system_class"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "wormhole_effects", force: :cascade do |t|
    t.float    "modifier"
    t.string   "affected"
    t.string   "anomaly"
    t.integer  "system_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
