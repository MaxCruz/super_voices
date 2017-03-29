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

ActiveRecord::Schema.define(version: 20170312220835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "company_contests", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.string   "url"
    t.datetime "start"
    t.datetime "end"
    t.decimal  "payment"
    t.text     "script"
    t.text     "guidelines"
    t.integer  "company_administrator_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "contests", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.string   "url"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "reward"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "administrator_id"
    t.text     "script"
    t.text     "recomendations"
  end

  create_table "voices", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "last_name"
    t.boolean  "done",            default: false
    t.text     "message"
    t.string   "source_url"
    t.string   "destination_url"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "contest_id"
  end

end
