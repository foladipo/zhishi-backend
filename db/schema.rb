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

ActiveRecord::Schema.define(version: 20160129095819) do

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.string   "content"
    t.integer  "votes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "votes"
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
    t.integer  "votes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_providers", force: :cascade do |t|
    t.string   "provider"
    t.string   "uuid"
    t.string   "auth_token"
    t.string   "refresh_token"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "token"
    t.string   "profile_picture"
    t.string   "profile_url"
    t.string   "profile_email"
  end

  add_index "social_providers", ["user_id"], name: "index_social_providers_on_user_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "subscriber_id"
    t.string   "subscriber_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "tags", ["subscriber_type", "subscriber_id"], name: "index_tags_on_subscriber_type_and_subscriber_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "uuid"
    t.string   "provider"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
  end

end