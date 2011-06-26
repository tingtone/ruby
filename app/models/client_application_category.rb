class ClientApplicationCategory < ActiveRecord::Base
  belongs_to :client_application
  belongs_to :category
end
