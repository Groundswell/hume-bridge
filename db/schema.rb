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

ActiveRecord::Schema.define(version: 20171104132200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_points", force: :cascade do |t|
    t.string   "device_id"
    t.string   "device_name"
    t.string   "date"
    t.string   "time"
    t.float    "acceleration_xaxis"
    t.float    "acceleration_yaxis"
    t.float    "acceleration_zaxis"
    t.float    "angular_velocity_xaxis"
    t.float    "angular_velocity_yaxis"
    t.float    "angular_velocity_zaxis"
    t.float    "angle_xaxis"
    t.float    "angle_yaxis"
    t.float    "angle_zaxis"
    t.text     "raw_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags",                   default: [], array: true
    t.index ["device_id", "id"], name: "index_data_points_on_device_id_and_id", using: :btree
    t.index ["tags"], name: "index_data_points_on_tags", using: :gin
  end

end
