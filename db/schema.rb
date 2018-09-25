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

ActiveRecord::Schema.define(version: 2018_09_25_072635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beachcleans", force: :cascade do |t|
    t.string "uuid"
    t.date "date"
    t.bigint "place_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "signed"
    t.index ["place_id"], name: "index_beachcleans_on_place_id"
    t.index ["user_id"], name: "index_beachcleans_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "beachclean_id"
    t.string "category"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beachclean_id"], name: "index_items_on_beachclean_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.string "email"
    t.string "encrypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
  end

  add_foreign_key "beachcleans", "places"
  add_foreign_key "beachcleans", "users"
  add_foreign_key "items", "beachcleans"
end
