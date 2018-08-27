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

ActiveRecord::Schema.define(version: 2018_08_27_073704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.bigint "scope_id"
    t.string "category"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scope_id"], name: "index_items_on_scope_id"
  end

  create_table "observations", force: :cascade do |t|
    t.bigint "scope_id"
    t.string "species"
    t.string "behaviour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scope_id"], name: "index_observations_on_scope_id"
  end

  create_table "scopes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "place"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scopes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "items", "scopes"
  add_foreign_key "observations", "scopes"
  add_foreign_key "scopes", "users"
end
