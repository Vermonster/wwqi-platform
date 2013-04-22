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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130430154741) do

  create_table "collaborators", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "collaborators", ["post_id"], :name => "index_collaborators_on_post_id"

  create_table "collaborators", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "collaborators", ["post_id"], :name => "index_collaborators_on_post_id"

  create_table "comments", :force => true do |t|
    t.text     "details"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "contributions", :force => true do |t|
    t.string   "details"
    t.string   "type"
    t.string   "item_id"
    t.integer  "creator_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "comments_count", :default => 0
  end

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "url"
    t.integer  "post_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "name"
    t.string   "thumbnail"
    t.integer  "accession_no"
  end

  add_index "items", ["post_id"], :name => "index_items_on_post_id"

  create_table "notifications", :force => true do |t|
    t.boolean  "unread",          :default => true
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "details"
    t.boolean  "item_related",   :default => false
    t.boolean  "private",        :default => false
    t.string   "type"
    t.integer  "creator_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "comments_count", :default => 0
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "uploads", :force => true do |t|
    t.string   "content"
    t.integer  "uploadable_id"
    t.string   "uploadable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",                             :null => false
    t.string   "last_name",                              :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
