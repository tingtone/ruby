Factory.define :grade do |g|
  g.sequence(:name) { |n| "grade#{n}" }
  g.sequence(:min_score) { |n| 1000 * n }
  g.sequence(:max_score) { |n| 1000 * (n + 1) - 1 }
end
