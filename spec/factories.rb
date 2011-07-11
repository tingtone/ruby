Factory.define :app do |a|
  a.sequence(:name) { |n| "name#{n}" }
  a.sequence(:description) { |n| "description#{n}" }
  a.price 1.0
  a.association :category
  a.association :developer
end

Factory.define :user do |d|
  d.sequence(:name) { |n| "user#{n}" }
  d.sequence(:email) { |n| "user#{n}@kittypad.com" }
  d.password "password"
  d.password_confirmation "password"
end

Factory.define :developer, :class => Developer, :parent => :user do |d|
end

Factory.define :owner, :class => Owner, :parent => :user do |o|
end

Factory.define :player do |p|
  p.association :owner
end

Factory.define :category do |c|
  c.sequence(:name) { |n| "category#{n}" }
end
