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

ActiveRecord::Schema.define(version: 20160822183512) do

  create_table "playlist_entries", force: :cascade do |t|
    t.integer  "sequence"
    t.integer  "video_id"
    t.integer  "playlist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "email"
    t.string   "password_hash"
    t.string   "username"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "view_count",              default: 0
    t.string   "video_file_file_name"
    t.string   "video_file_content_type"
    t.integer  "video_file_file_size"
    t.datetime "video_file_updated_at"
    t.integer  "user_id"
  end

end
