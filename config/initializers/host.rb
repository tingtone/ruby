if Rails.env.development? || Rails.env.test?
  RAILS_HOST = 'http://localhost:3000'
else
  RAILS_HOST = 'http://api.kittypad.com'
end
