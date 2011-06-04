class Bonus < ActiveRecord::Base
  TIME = 15
  EXPIRE_WEEKS = 12

  belongs_to :child
end
