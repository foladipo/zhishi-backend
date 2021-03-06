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

ActiveRecord::Schema.define(version: 20160706131029) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.string   "content"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "comments_count", default: 0
    t.boolean  "accepted",       default: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "comment_on_id"
    t.string   "comment_on_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "comments", ["comment_on_type", "comment_on_id"], name: "index_comments_on_comment_on_type_and_comment_on_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "content"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "views",          default: 0
    t.integer  "comments_count", default: 0
    t.integer  "answers_count",  default: 0
  end

  create_table "resource_tags", force: :cascade do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tag_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "resource_tags", ["tag_id"], name: "index_resource_tags_on_tag_id"
  add_index "resource_tags", ["taggable_type", "taggable_id"], name: "index_resource_tags_on_taggable_type_and_taggable_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "representative_id"
  end

  add_index "tags", ["name"], name: "index_tags_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "points",     default: 10
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "active"
    t.string   "image"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "value"
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id"
  add_index "votes", ["voteable_type", "voteable_id"], name: "index_votes_on_voteable_type_and_voteable_id"

end
