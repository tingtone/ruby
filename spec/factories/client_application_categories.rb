Factory.define :client_application_category do |c|
  c.association :client_application
  c.association :category
end
