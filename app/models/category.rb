class Category < ActiveRecord::Base
  has_many :client_application_categories
end
