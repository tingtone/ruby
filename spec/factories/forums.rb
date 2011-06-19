Factory.define :forum do |p|
  p.id 1
  p.name 'Control Room'
  p.description 'Talk about something of the ParentDashboard'
  p.topics_count 0
  p.posts_count 0
  p.position 1
  p.description_html '<p>Talk about something of the ParentDashboard</p>'
  p.state 'public'
  p.permalink 'control-room'
end

Factory.define :forum_two, :class => :forum do |p|
  p.id 2
  p.name 'Others'
  p.description 'Talk about something of the Others'
  p.topics_count 0
  p.posts_count 0
  p.position 2
  p.description_html '<p>Talk about something of the Others</p>'
  p.state 'public'
  p.permalink 'others'
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