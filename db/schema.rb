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

ActiveRecord::Schema.define(version: 2018_10_10_095125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dresses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "category_id"
    t.string "remark"
    t.string "color"
    t.float "price"
    t.integer "stock"
    t.float "cm_length"
    t.float "cm_bust"
    t.float "cm_waist"
    t.float "cm_hip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "images"
    t.index ["category_id"], name: "index_dresses_on_category_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "registers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "field_1"
    t.string "field_2"
    t.string "field_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_dress_likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "dress_id"
    t.boolean "like", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dress_id"], name: "index_user_dress_likes_on_dress_id"
    t.index ["user_id"], name: "index_user_dress_likes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.date "birthday"
    t.string "password_digest"
    t.string "remember_digest"
    t.integer "role", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
  end

end
