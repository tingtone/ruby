Factory.define :parent do |p|
  p.sequence(:email) { |n| "parent#{i}@test.com" }
  p.password "parent"
  p.password_confirmation "parent"
end
