Factory.define :topic do |t|
    t.forum_id 1
    t.parent_id 0
    t.title  "hello world"
    t.hits    0
    t.sticky 0
    t.posts_count 0
    t.locked false
    t.last_post_id  0
    t.last_updated_at Time.now
    t.last_user_id 0
    t.permalink  ''
    t.created_at Time.now
    t.updated_at Time.now
end

#    t.integer  "forum_id"
#    t.integer  "parent_id"
#    t.string   "title"
#    t.integer  "hits",            :default => 0
#    t.integer  "sticky",          :default => 0
#    t.integer  "posts_count",     :default => 0
#    t.boolean  "locked",          :default => false
#    t.integer  "last_post_id"
#    t.datetime "last_updated_at"
#    t.integer  "last_user_id"
#    t.string   "permalink"
#    t.datetime "created_at"
#    t.datetime "updated_at"