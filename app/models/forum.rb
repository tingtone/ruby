class Forum < ActiveRecord::Base
  has_many   :topics, :counter_cache => true
  belongs_to :parent
end