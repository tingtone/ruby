Factory.define :achievement do |a|
  a.association :child
  a.association :grade
  a.association :category
end
