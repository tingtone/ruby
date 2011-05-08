class ParentClientApplication < ActiveRecord::Base
  belongs_to :parent
  belongs_to :client_application
end
