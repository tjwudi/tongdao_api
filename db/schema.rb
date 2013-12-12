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

ActiveRecord::Schema.define(version: 20131212030226) do

  create_table "conversations", force: true do |t|
    t.integer  "user_alpha_id"
    t.integer  "user_beta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "user_alpha_is_read"
    t.boolean  "user_beta_is_read"
  end

  create_table "follows", force: true do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "likes", force: true do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.boolean  "is_owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["project_id"], name: "index_memberships_on_project_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "mentions", force: true do |t|
    t.string   "mentioner_type"
    t.integer  "mentioner_id"
    t.string   "mentionable_type"
    t.integer  "mentionable_id"
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
  add_index "mentions", ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.text     "introduction"
    t.string   "avatar"
    t.integer  "administrator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pending_users", force: true do |t|
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pending_users", ["email"], name: "index_pending_users_on_email", unique: true, using: :btree

  create_table "project_comments", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.text     "content"
    t.string   "emotion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_post_id"
  end

  add_index "project_comments", ["project_id"], name: "index_project_comments_on_project_id", using: :btree
  add_index "project_comments", ["user_id"], name: "index_project_comments_on_user_id", using: :btree

  create_table "project_posts", force: true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_posts", ["project_id"], name: "index_project_posts_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "category"
    t.string   "school"
    t.string   "state"
    t.text     "summary"
    t.string   "feature_photo"
    t.integer  "count_of_views", default: 0, null: false
    t.integer  "count_of_likes", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["category"], name: "index_projects_on_category", using: :btree
  add_index "projects", ["school"], name: "index_projects_on_school", using: :btree
  add_index "projects", ["title"], name: "index_projects_on_title", using: :btree

  create_table "public_activities", force: true do |t|
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.text     "content"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tag_attachments", force: true do |t|
    t.integer  "tag_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_attachments", ["project_id"], name: "index_tag_attachments_on_project_id", using: :btree
  add_index "tag_attachments", ["tag_id"], name: "index_tag_attachments_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "count_of_tag_attachments", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "tokens", force: true do |t|
    t.string   "token",      null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                           null: false
    t.string   "encrypted_password",              null: false
    t.string   "nickname",                        null: false
    t.string   "gender"
    t.string   "contact"
    t.string   "school"
    t.string   "major"
    t.string   "speciality"
    t.string   "experence"
    t.string   "avatar"
    t.integer  "count_of_followers",  default: 0, null: false
    t.integer  "count_of_followings", default: 0, null: false
    t.datetime "last_login_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
  add_index "users", ["school"], name: "index_users_on_school", unique: true, using: :btree

end
