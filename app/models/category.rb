class Category < ActiveRecord::Base
  has_many :apps
  
  has_ancestry
  
  validates :name, :presence => true, :uniqueness => true
end
