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

ActiveRecord::Schema.define(version: 20151128220309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assoc_contact_events", force: true do |t|
    t.integer "event_contact_id"
    t.integer "event_id"
    t.boolean "contact_is_primary"
  end

  create_table "carousels", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["title"], name: "index_contents_on_title", using: :btree

  create_table "entries", force: true do |t|
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
    t.integer "bib_number"
  end

  add_index "entries", ["age"], name: "index_entries_on_age", using: :btree
  add_index "entries", ["chip_number"], name: "index_entries_on_chip_number", using: :btree
  add_index "entries", ["city"], name: "index_entries_on_city", using: :btree
  add_index "entries", ["division"], name: "index_entries_on_division", using: :btree
  add_index "entries", ["email"], name: "index_entries_on_email", using: :btree
  add_index "entries", ["first_name"], name: "index_entries_on_first_name", using: :btree
  add_index "entries", ["gender"], name: "index_entries_on_gender", using: :btree
  add_index "entries", ["last_name"], name: "index_entries_on_last_name", using: :btree
  add_index "entries", ["race_id"], name: "index_entries_on_race_id", using: :btree
  add_index "entries", ["sms_phone"], name: "index_entries_on_sms_phone", using: :btree
  add_index "entries", ["state"], name: "index_entries_on_state", using: :btree
  add_index "entries", ["team_name"], name: "index_entries_on_team_name", using: :btree
  add_index "entries", ["unique_id"], name: "index_entries_on_unique_id", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "event_contacts", force: true do |t|
    t.string "company_name"
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "email"
    t.string "phone"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.text   "notes"
  end

  create_table "event_groups", force: true do |t|
    t.string  "name"
    t.integer "contact_id"
  end

  create_table "event_types", force: true do |t|
    t.string "name"
  end

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
    t.string   "place_id"
    t.string   "database_file_path"
    t.string   "division_file_path"
    t.string   "group_file_path"
    t.integer  "finishers_only"
    t.string   "cover_photo"
    t.float    "cover_position"
    t.string   "start_time"
    t.string   "end_time"
    t.integer  "live_update_interval",     default: 60
    t.integer  "event_type_id"
    t.string   "website"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "number_of_participants"
    t.string   "online_registration_link"
    t.integer  "billing_contact_id"
    t.string   "notes"
    t.string   "results_url"
    t.string   "course_map_url"
    t.integer  "timer_id"
    t.integer  "event_group_id"
    t.boolean  "is_visible"
  end

  add_index "events", ["date_time"], name: "index_events_on_date_time", using: :btree
  add_index "events", ["end_time"], name: "index_events_on_end_time", using: :btree
  add_index "events", ["location"], name: "index_events_on_location", using: :btree
  add_index "events", ["name"], name: "index_events_on_name", using: :btree
  add_index "events", ["place_id"], name: "index_events_on_place_id", using: :btree
  add_index "events", ["start_time"], name: "index_events_on_start_time", using: :btree

  create_table "group_defaults", force: true do |t|
    t.string   "gender"
    t.integer  "top_exclusions"
    t.integer  "masters_age_start"
    t.integer  "masters_inclusions"
    t.integer  "grand_masters_age_start"
    t.integer  "grand_masters_inclusions"
    t.integer  "senior_masters_age_start"
    t.integer  "senior_masters_inclusions"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_defaults", ["race_id"], name: "index_group_defaults_on_race_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "gender"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "bottom_age"
    t.string   "top_age"
  end

  add_index "groups", ["race_id"], name: "index_groups_on_race_id", using: :btree

  create_table "interactions", force: true do |t|
    t.integer  "event_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "needs_contact"
    t.date     "date"
  end

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
    t.string   "group_page"
    t.string   "start_field"
  end

  add_index "races", ["event_id"], name: "index_races_on_event_id", using: :btree

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

  create_table "timers", force: true do |t|
    t.string "name"
    t.string "url"
    t.string "phone"
    t.string "equipment"
    t.string "email"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email"
    t.string   "session_token"
    t.integer  "admin"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

end
