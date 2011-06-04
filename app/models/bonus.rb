class Bonus < ActiveRecord::Base
  TIME = 15

  belongs_to :child
end
