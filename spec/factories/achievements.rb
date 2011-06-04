Factory.define :achievement do |a|
  a.association :child
  a.association :grade
  a.association :client_application_category
end
