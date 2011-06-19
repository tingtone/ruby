Factory.define :parent do |p|
  p.sequence(:id) {|n| n }
  p.sequence(:email) { |n| "parent#{n}@test.com" }
  p.password "parent"
  p.password_confirmation "parent"
end
