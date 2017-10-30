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

ActiveRecord::Schema.define(version: 20170524201918) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_categories_on_id", unique: true
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "categories_courses", id: false, force: :cascade do |t|
    t.integer "course_id",   null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_categories_courses_on_category_id"
    t.index ["course_id"], name: "index_categories_courses_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.index ["id"], name: "index_courses_on_id", unique: true
    t.index ["name"], name: "index_courses_on_name", unique: true
  end

  create_table "courses_locations", id: false, force: :cascade do |t|
    t.integer "course_id",   null: false
    t.integer "location_id", null: false
    t.index ["course_id"], name: "index_courses_locations_on_course_id"
    t.index ["location_id"], name: "index_courses_locations_on_location_id"
  end

  create_table "courses_prerequisites", id: false, force: :cascade do |t|
    t.integer "course_id",       null: false
    t.integer "prerequisite_id", null: false
    t.index ["course_id"], name: "index_courses_prerequisites_on_course_id"
    t.index ["prerequisite_id"], name: "index_courses_prerequisites_on_prerequisite_id"
  end

  create_table "downvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_locations_on_id", unique: true
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "prerequisites", force: :cascade do |t|
  end

  create_table "upvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id"], name: "index_users_on_id", unique: true
  end

end
