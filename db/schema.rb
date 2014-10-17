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

ActiveRecord::Schema.define(version: 20141015235113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "title"
    t.string  "bio"
    t.integer "cv_id"
    t.string  "state"
    t.integer "external_user_id"
  end

  create_table "external_users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", force: true do |t|
    t.string  "title"
    t.integer "inh_user_id"
    t.json    "json"
  end

  create_table "inh_ext_contracts", force: true do |t|
    t.integer  "ext_user_id"
    t.integer  "inh_user_id"
    t.boolean  "ext_accepted"
    t.boolean  "inh_accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inhouse_users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "location"
    t.integer  "form_id"
    t.integer  "inh_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submitted_candidates", force: true do |t|
    t.integer "job_id"
    t.integer "candidate_id"
    t.json    "form_json"
    t.boolean "accepted"
    t.string  "progress"
  end

end
