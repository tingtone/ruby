class Category < ActiveRecord::Base
  acts_as_nested_set
  
  validates :name, :presence => true, :uniqueness => true
end
