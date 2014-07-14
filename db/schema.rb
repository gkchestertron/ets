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

ActiveRecord::Schema.define(version: 20140706044422) do

  create_table "entries", force: true do |t|
    t.integer "bib_number"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "gun_start"
    t.string  "chip_start"
    t.string  "split_1"
    t.string  "split_2"
    t.string  "split_3"
    t.string  "split_4"
    t.string  "split_5"
    t.string  "split_6"
    t.string  "split_7"
    t.string  "split_8"
    t.string  "split_9"
    t.string  "split_10"
    t.string  "finish_time"
    t.string  "adjustment_time"
    t.string  "gun_elapsed_time"
    t.string  "chip_elapsed_time"
    t.integer "age"
    t.string  "division"
    t.string  "gender"
    t.string  "city"
    t.string  "state"
    t.string  "team_name"
    t.integer "team_order"
    t.string  "sms_phone"
    t.string  "email"
    t.integer "chip_number"
    t.string  "user_field_1"
    t.string  "user_field_2"
    t.string  "user_field_3"
    t.integer "unique_id"
    t.string  "photo_files"
    t.integer "user_id"
    t.integer "race_id"
  end

  add_index "entries", ["age"], name: "index_entries_on_age"
  add_index "entries", ["chip_number"], name: "index_entries_on_chip_number"
  add_index "entries", ["city"], name: "index_entries_on_city"
  add_index "entries", ["division"], name: "index_entries_on_division"
  add_index "entries", ["email"], name: "index_entries_on_email"
  add_index "entries", ["first_name"], name: "index_entries_on_first_name"
  add_index "entries", ["gender"], name: "index_entries_on_gender"
  add_index "entries", ["last_name"], name: "index_entries_on_last_name"
  add_index "entries", ["race_id"], name: "index_entries_on_race_id"
  add_index "entries", ["sms_phone"], name: "index_entries_on_sms_phone"
  add_index "entries", ["state"], name: "index_entries_on_state"
  add_index "entries", ["team_name"], name: "index_entries_on_team_name"
  add_index "entries", ["unique_id"], name: "index_entries_on_unique_id"
  add_index "entries", ["user_id"], name: "index_entries_on_user_id"

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "location"
    t.string   "date_time"
    t.text     "description"
    t.string   "import_path"
    t.string   "user_field_1_label"
    t.string   "user_field_2_label"
    t.string   "user_field_3_label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "age_range"
    t.string   "gender"
    t.string   "exclusions"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["race_id"], name: "index_groups_on_race_id"

  create_table "race_directorships", force: true do |t|
    t.integer  "user_id"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.string   "division"
  end

  add_index "races", ["event_id"], name: "index_races_on_event_id"

  create_table "split_templates", force: true do |t|
    t.string   "label"
    t.string   "diff_field_1"
    t.string   "diff_field_2"
    t.integer  "order"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "distance"
  end

  create_table "splits", force: true do |t|
    t.integer  "entry_id"
    t.string   "time"
    t.string   "length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
    t.integer  "order"
    t.float    "distance"
    t.float    "rate"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
