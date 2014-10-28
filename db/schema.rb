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

ActiveRecord::Schema.define(version: 20140911172619) do

  create_table "conditions", force: true do |t|
    t.string   "column"
    t.string   "parameter"
    t.integer  "operator_id"
    t.integer  "query_id"
    t.string   "complexOperator"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conditions", ["operator_id"], name: "index_conditions_on_operator_id", using: :btree
  add_index "conditions", ["query_id"], name: "index_conditions_on_query_id", using: :btree

  create_table "controls", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.text     "question"
    t.string   "result_set_hash"
    t.text     "description"
    t.text     "response_correct"
    t.text     "response_incorrect"
    t.integer  "lesson_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercises", ["lesson_id"], name: "index_exercises_on_lesson_id", using: :btree

  create_table "lessons", force: true do |t|
    t.text     "title"
    t.text     "objective"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locales", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", force: true do |t|
    t.string   "name"
    t.string   "sql_value"
    t.string   "html_representation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queries", force: true do |t|
    t.integer  "dummy_id"
    t.text     "raw_sql"
    t.integer  "status",      limit: 1,          default: 0
    t.text     "html_table",  limit: 2147483647
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "queries", ["exercise_id"], name: "index_queries_on_exercise_id", using: :btree
  add_index "queries", ["user_id"], name: "index_queries_on_user_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "chief"
    t.integer  "control_id"
    t.integer  "locale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["control_id"], name: "index_schools_on_control_id", using: :btree
  add_index "schools", ["locale_id"], name: "index_schools_on_locale_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.boolean  "visual_interface"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
