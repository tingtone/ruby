class ClientApplicationLanguage < ActiveRecord::Base
  belongs_to :client_application
  belongs_to :language
end
