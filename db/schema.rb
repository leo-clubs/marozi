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

ActiveRecord::Schema.define(version: 20131030151952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: true do |t|
    t.integer  "oid"
    t.string   "year"
    t.boolean  "current"
    t.string   "name"
    t.date     "founded_at"
    t.date     "chartered_at"
    t.string   "godfather"
    t.string   "meet_description"
    t.string   "bank"
    t.string   "homepage"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clubs", ["year", "oid"], name: "index_clubs_on_year_and_oid", where: "current", using: :btree

  create_table "committees", force: true do |t|
    t.integer  "oid"
    t.string   "year"
    t.boolean  "current"
    t.string   "kind"
    t.integer  "chairperson_id"
    t.integer  "member_ids",           array: true
    t.integer  "multiple_district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "committees", ["year", "oid"], name: "index_committees_on_year_and_oid", where: "current", using: :btree

  create_table "contact_infos", force: true do |t|
    t.string   "kind"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "mobile_phone_number"
    t.string   "fax_number"
    t.string   "homepage"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: true do |t|
    t.integer "oid"
    t.string  "year"
    t.boolean "current"
    t.string  "name"
    t.integer "multiple_district_id"
  end

  add_index "districts", ["year", "oid"], name: "index_districts_on_year_and_oid", where: "current", using: :btree

  create_table "members", force: true do |t|
    t.integer  "oid"
    t.string   "year"
    t.boolean  "current"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "languages",      array: true
    t.string   "profession"
    t.string   "status"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "academic_title"
  end

  add_index "members", ["year", "oid"], name: "index_members_on_year_and_oid", where: "current", using: :btree

  create_table "memberships", force: true do |t|
    t.date     "from"
    t.date     "to"
    t.integer  "member_id"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multiple_districts", force: true do |t|
    t.integer  "oid"
    t.string   "year"
    t.boolean  "current"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "multiple_districts", ["year", "oid"], name: "index_multiple_districts_on_year_and_oid", where: "current", using: :btree

  create_table "offices", force: true do |t|
    t.integer "oid"
    t.string  "year"
    t.boolean "current"
    t.string  "name"
    t.integer "provides_offices_id"
    t.string  "provides_offices_type"
    t.integer "member_id"
  end

  add_index "offices", ["year", "oid"], name: "index_offices_on_year_and_oid", where: "current", using: :btree

  create_table "settings", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "multiple_district"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
