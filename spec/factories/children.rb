Factory.define :child do |c|
  c.sequence(:email) { |n| "child#{n}@test.com" }
  c.password "children"
  c.password_confirmation "children"
  c.association :parent
end
