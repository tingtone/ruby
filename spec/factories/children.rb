Factory.define :child do |c|
  c.sequence(:fullname) { |n| "Child1" }
  c.gender 'male'
  c.birthday '936806400'
  c.association :parent
end
