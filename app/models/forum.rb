class Forum < ActiveRecord::Base
  has_many   :topics
  belongs_to :parent
end