class Language < ActiveRecord::Base
  has_many :client_application_languages
end
