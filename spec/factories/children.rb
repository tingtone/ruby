Factory.define :child do |c|
  c.sequence(:fullname) { |n| "Child1" }
  c.gender 'male'
  c.birthday '1999-9-9'
end
