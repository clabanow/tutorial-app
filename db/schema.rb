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

ActiveRecord::Schema.define(version: 20140919171632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "language_tutorials", force: true do |t|
    t.integer  "tutorial_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "language_tutorials", ["language_id"], name: "index_language_tutorials_on_language_id", using: :btree
  add_index "language_tutorials", ["tutorial_id"], name: "index_language_tutorials_on_tutorial_id", using: :btree

  create_table "languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["name"], name: "index_languages_on_name", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "topics", force: true do |t|
    t.integer  "tag_id"
    t.integer  "tutorial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["tag_id"], name: "index_topics_on_tag_id", using: :btree
  add_index "topics", ["tutorial_id"], name: "index_topics_on_tutorial_id", using: :btree

  create_table "track_tutorials", force: true do |t|
    t.integer  "tutorial_id"
    t.integer  "track_id"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["name"], name: "index_tracks_on_name", using: :btree

  create_table "tutorials", force: true do |t|
    t.integer  "category_id"
    t.string   "url"
    t.string   "title"
    t.string   "description"
    t.integer  "publisher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "media_type_id"
    t.boolean  "is_paid"
    t.date     "date_created"
  end

  add_index "tutorials", ["category_id"], name: "index_tutorials_on_category_id", using: :btree
  add_index "tutorials", ["publisher_id"], name: "index_tutorials_on_publisher_id", using: :btree
  add_index "tutorials", ["url"], name: "index_tutorials_on_url", unique: true, using: :btree

end
