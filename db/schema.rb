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

ActiveRecord::Schema.define(version: 20131120184024) do

  create_table "post_comments", force: true do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.text    "content"
  end

  create_table "post_tags", force: true do |t|
    t.integer "post_id"
    t.string  "tag"
  end

  create_table "post_votes", force: true do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.binary  "value"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_on"
    t.text     "content"
    t.string   "title"
  end

  create_table "users", force: true do |t|
    t.integer "linkedin_id", limit: 255
    t.boolean "is_admin"
    t.string  "email"
    t.string  "name"
  end

  add_index "users", ["linkedin_id"], name: "index_users_on_linkedin_id", unique: true

end
