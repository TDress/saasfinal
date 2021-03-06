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

ActiveRecord::Schema.define(version: 20131219065459) do

  create_table "post_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_on"
  end

  add_index "post_comments", ["post_id"], name: "index_post_comments_on_post_id"

  create_table "post_tags", force: true do |t|
    t.integer "post_id"
    t.string  "tag"
  end

  add_index "post_tags", ["post_id", "tag"], name: "index_post_tags_on_post_id_and_tag", unique: true

  create_table "post_votes", force: true do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.integer "value"
  end

  add_index "post_votes", ["post_id", "user_id"], name: "index_post_votes_on_post_id_and_user_id", unique: true

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_on"
    t.text     "content"
    t.string   "title"
    t.integer  "vote_sum",   default: 0
  end

  create_table "users", force: true do |t|
    t.boolean "is_admin"
    t.string  "email"
    t.string  "name"
    t.string  "linkedin_id"
    t.string  "linkedin_url"
    t.string  "profile_picture_url", default: "/assets/no-image.png"
  end

end
