class GameApplication < ClientApplication
  validates_presence_of :subject, :unless => :new_record?
  validates_presence_of :start_age, :unless => :new_record?
  validates_presence_of :end_age, :unless => :new_record?
  validates_presence_of :icon, :unless => :new_record?
  validates_presence_of :screenshot, :unless => :new_record?
  validates_presence_of :app_store_url, :unless => :new_record?
end
