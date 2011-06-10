Factory.define :forum do |p|
  p.name 'Control Room'
  p.description 'Talk about something of the ParentDashboard'
  p.topics_count 0
  p.posts_count 0
  p.position 1
  p.description_html '<p>Talk about something of the ParentDashboard</p>'
  p.state 'public'
  p.permalink 'control-room'
end

# t.string   "name"
# t.string   "description"
# t.integer  "topics_count",     :default => 0
# t.integer  "posts_count",      :default => 0
# t.integer  "position",         :default => 0
# t.text     "description_html"
# t.string   "state",            :default => "public"
# t.string   "permalink"
# t.datetime "created_at"
# t.datetime "updated_at"