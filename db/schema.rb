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

ActiveRecord::Schema.define(version: 20160312183524) do

  create_table "book_availabilities", force: :cascade do |t|
    t.integer  "user_book_id",       limit: 4
    t.datetime "start_availability"
    t.datetime "end_availability"
  end

  create_table "books", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.integer "category_id", limit: 4
    t.integer "edition",     limit: 4
  end

  create_table "categories", force: :cascade do |t|
    t.integer "name", limit: 4
  end

  create_table "rent_user_books", force: :cascade do |t|
    t.integer  "user_book_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name",     limit: 255
    t.string "location", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "facebook_id", limit: 255
    t.string  "email",       limit: 255
    t.integer "school_id",   limit: 4
  end

  create_table "users_books", force: :cascade do |t|
    t.integer "user_id",              limit: 4
    t.integer "book_id",              limit: 4
    t.boolean "status"
    t.integer "book_availability_id", limit: 4
    t.boolean "sent"
    t.boolean "returned"
    t.decimal "price_per_hour",                 precision: 10
  end

end
