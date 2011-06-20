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

ActiveRecord::Schema.define(:version => 20110618140550) do

  create_table "achievements", :force => true do |t|
    t.integer  "grade_id"
    t.integer  "score",                          :default => 0
    t.integer  "child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_application_category_id"
  end

  create_table "age_grades", :force => true do |t|
    t.integer  "age"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bonus", :force => true do |t|
    t.integer  "child_id"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "expired_on"
  end

  create_table "children", :force => true do |t|
    t.string   "fullname"
    t.string   "gender"
    t.date     "birthday"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "client_application_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_applications", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.string   "secret"
    t.integer  "developer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.text     "description"
    t.integer  "client_application_category_id"
    t.integer  "rating"
    t.string   "identifier"
    t.integer  "max_score",                      :default => 0
    t.integer  "start_age"
    t.integer  "end_age"
    t.string   "app_store_url"
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.integer  "screenshot_file_size"
    t.datetime "screenshot_updated_at"
    t.integer  "click_times"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "subject"
  end

  create_table "developers", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "developers", ["email"], :name => "index_developers_on_email", :unique => true
  add_index "developers", ["reset_password_token"], :name => "index_developers_on_reset_password_token", :unique => true

  create_table "devices", :force => true do |t|
    t.string   "identifier"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "topics_count",     :default => 0
    t.integer  "posts_count",      :default => 0
    t.integer  "position",         :default => 0
    t.text     "description_html"
    t.string   "state",            :default => "public"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forums", ["permalink"], :name => "index_forums_on_permalink"
  add_index "forums", ["position"], :name => "index_forums_on_position"

  create_table "grades", :force => true do |t|
    t.string   "name"
    t.integer  "min_score"
    t.integer  "max_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  create_table "moderatorships", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "moderatorships", ["forum_id"], :name => "index_moderatorships_on_forum_id"
  add_index "moderatorships", ["parent_id", "forum_id"], :name => "index_moderatorships_on_forum_id_and_parent_id"

  create_table "most_downloads", :force => true do |t|
    t.integer  "client_application_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "most_playeds", :force => true do |t|
    t.integer  "client_application_id"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parent_client_applications", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "client_application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parents", :force => true do |t|
    t.string   "email",                                      :default => "", :null => false
    t.string   "encrypted_password",          :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                              :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.integer  "posts_count",                                :default => 0
    t.datetime "children_updated_at"
    t.datetime "rule_definitions_updated_at"
    t.datetime "bonus_updated_at"
    t.string   "client_encrypted_password"
  end

  add_index "parents", ["email"], :name => "index_parents_on_email", :unique => true
  add_index "parents", ["reset_password_token"], :name => "index_parents_on_reset_password_token", :unique => true

  create_table "posts", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "topic_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id"
    t.text     "body_html"
  end

  add_index "posts", ["created_at", "forum_id"], :name => "index_posts_on_forum_id"
  add_index "posts", ["created_at", "parent_id"], :name => "index_posts_on_parent_id"
  add_index "posts", ["created_at", "topic_id"], :name => "index_posts_on_topic_id"

  create_table "rule_definitions", :force => true do |t|
    t.integer  "time"
    t.string   "period"
    t.integer  "client_application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "child_id"
  end

  create_table "score_trackers", :force => true do |t|
    t.integer  "child_id"
    t.integer  "client_application_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "time_trackers", :force => true do |t|
    t.integer  "child_id"
    t.integer  "client_application_id"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "parent_id"
    t.string   "title"
    t.integer  "hits",            :default => 0
    t.integer  "sticky",          :default => 0
    t.integer  "posts_count",     :default => 0
    t.boolean  "locked",          :default => false
    t.integer  "last_post_id"
    t.datetime "last_updated_at"
    t.integer  "last_user_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["forum_id", "permalink"], :name => "index_topics_on_forum_id_and_permalink"
  add_index "topics", ["last_updated_at", "forum_id"], :name => "index_topics_on_forum_id_and_last_updated_at"
  add_index "topics", ["sticky", "last_updated_at", "forum_id"], :name => "index_topics_on_sticky_and_last_updated_at"

end
