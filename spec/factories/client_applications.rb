Factory.define :client_application do |a|
  a.sequence(:name) { |n| "name#{n}" }
  a.description "Description"
end
