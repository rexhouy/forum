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

ActiveRecord::Schema.define(version: 20160418052412) do

  create_table "access_logs", force: :cascade do |t|
    t.string   "resource_name", limit: 255, null: false
    t.integer  "resource_id",   limit: 4,   null: false
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "captchas", force: :cascade do |t|
    t.string   "tel",              limit: 11, null: false
    t.string   "register_token",   limit: 6,  null: false
    t.datetime "register_sent_at",            null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "captchas", ["tel"], name: "index_captchas_on_tel", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "chats", force: :cascade do |t|
    t.text     "text",       limit: 65535
    t.string   "name",       limit: 255
    t.string   "avatar",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "topic_id",   limit: 4
  end

  create_table "enroll_histories", force: :cascade do |t|
    t.integer  "enroll_id",  limit: 4
    t.integer  "status",     limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "enrolls", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "status",     limit: 4
    t.string   "order_id",   limit: 255
    t.decimal  "fee",                      precision: 8, scale: 2
    t.integer  "topic_id",   limit: 4
    t.string   "tel",        limit: 255
  end

  create_table "payments", force: :cascade do |t|
    t.text     "trade_info", limit: 65535
    t.integer  "enroll_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "favorite",   limit: 4
    t.integer  "topic_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "topic_id",   limit: 4
    t.boolean  "required",   limit: 1
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.text     "content",           limit: 65535
    t.integer  "favorite",          limit: 4
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "category_id",       limit: 4
    t.boolean  "priority",          limit: 1
    t.boolean  "enroll",            limit: 1
    t.decimal  "enroll_fee",                      precision: 8, scale: 2
    t.decimal  "enroll_promotion",                precision: 8, scale: 2
    t.string   "desc",              limit: 255
    t.string   "cover_image",       limit: 255
    t.datetime "enroll_start_date"
    t.datetime "enroll_end_date"
    t.datetime "start_time"
    t.string   "location",          limit: 255
    t.integer  "min_places",        limit: 4
    t.integer  "max_places",        limit: 4
  end

  create_table "user_favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "topic_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_favorites", ["user_id", "topic_id"], name: "index_user_favorites_on_user_id_and_topic_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "tel",                    limit: 11,  default: "", null: false
    t.string   "email",                  limit: 255
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.datetime "locked_at"
    t.string   "icon",                   limit: 255
    t.integer  "role",                   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",                 limit: 255
    t.string   "name",                   limit: 255
    t.boolean  "active",                 limit: 1
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["tel"], name: "index_users_on_tel", unique: true, using: :btree

end
