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

ActiveRecord::Schema.define(version: 20131117083439) do

  create_table "boxes", force: true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boxes", ["project_id"], name: "index_boxes_on_project_id", using: :btree

  create_table "boxes_stickers", force: true do |t|
    t.integer  "sticker_id"
    t.integer  "box_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boxes_stickers", ["box_id"], name: "index_boxes_stickers_on_box_id", using: :btree
  add_index "boxes_stickers", ["sticker_id"], name: "index_boxes_stickers_on_sticker_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.boolean  "is_owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["project_id"], name: "index_memberships_on_project_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "observe_entries", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.string   "feature_photo"
    t.integer  "user_id"
    t.integer  "count_of_observe_likes",   default: 0, null: false
    t.integer  "count_of_observe_threads", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "observe_entries", ["user_id"], name: "index_observe_entries_on_user_id", using: :btree

  create_table "observe_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "observe_entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "observe_likes", ["observe_entry_id"], name: "index_observe_likes_on_observe_entry_id", using: :btree
  add_index "observe_likes", ["user_id"], name: "index_observe_likes_on_user_id", using: :btree

  create_table "observe_threads", force: true do |t|
    t.integer  "user_id"
    t.integer  "observe_entry_id"
    t.text     "content"
    t.boolean  "is_primary"
    t.integer  "count_of_thread_likes",   default: 0, null: false
    t.integer  "count_of_thread_dislike", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "observe_threads", ["observe_entry_id"], name: "index_observe_threads_on_observe_entry_id", using: :btree
  add_index "observe_threads", ["user_id"], name: "index_observe_threads_on_user_id", using: :btree

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
  end

  add_index "project_comments", ["project_id"], name: "index_project_comments_on_project_id", using: :btree
  add_index "project_comments", ["user_id"], name: "index_project_comments_on_user_id", using: :btree

  create_table "project_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_likes", ["project_id"], name: "index_project_likes_on_project_id", using: :btree
  add_index "project_likes", ["user_id"], name: "index_project_likes_on_user_id", using: :btree

  create_table "project_posts", force: true do |t|
    t.integer  "project_id"
    t.boolean  "featured"
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
    t.integer  "count_of_project_likes", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["category"], name: "index_projects_on_category", using: :btree
  add_index "projects", ["school"], name: "index_projects_on_school", using: :btree
  add_index "projects", ["title"], name: "index_projects_on_title", using: :btree

  create_table "stickers", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.text     "content"
    t.boolean  "requires_feedback"
    t.string   "files"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stickers", ["project_id"], name: "index_stickers_on_project_id", using: :btree
  add_index "stickers", ["user_id"], name: "index_stickers_on_user_id", using: :btree

  create_table "stickers_users", force: true do |t|
    t.integer  "sticker_id"
    t.boolean  "read"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stickers_users", ["sticker_id"], name: "index_stickers_users_on_sticker_id", using: :btree

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "task_groups", force: true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "task_groups", ["project_id"], name: "index_task_groups_on_project_id", using: :btree

  create_table "tasks", force: true do |t|
    t.integer  "task_group_id"
    t.integer  "progress"
    t.integer  "priority"
    t.text     "log"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["task_group_id"], name: "index_tasks_on_task_group_id", using: :btree

  create_table "tasks_users", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks_users", ["task_id"], name: "index_tasks_users_on_task_id", using: :btree
  add_index "tasks_users", ["user_id"], name: "index_tasks_users_on_user_id", using: :btree

  create_table "thread_dislikes", force: true do |t|
    t.integer  "user_id"
    t.integer  "observe_thread_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thread_dislikes", ["observe_thread_id"], name: "index_thread_dislikes_on_observe_thread_id", using: :btree
  add_index "thread_dislikes", ["user_id"], name: "index_thread_dislikes_on_user_id", using: :btree

  create_table "thread_likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "observe_thread_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thread_likes", ["observe_thread_id"], name: "index_thread_likes_on_observe_thread_id", using: :btree
  add_index "thread_likes", ["user_id"], name: "index_thread_likes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",              null: false
    t.string   "encrypted_password", null: false
    t.string   "nickname",           null: false
    t.string   "gender"
    t.string   "contact"
    t.string   "school"
    t.string   "speciality"
    t.string   "avatar"
    t.string   "auth_token"
    t.datetime "last_auth_time"
    t.datetime "last_login_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
  add_index "users", ["school"], name: "index_users_on_school", unique: true, using: :btree

end
