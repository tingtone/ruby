Factory.define :client_application do |a|
  a.sequence(:name) { |n| "name#{n}" }
  a.description "Description"
  a.sequence(:identifier) { |n| "com.apple.identifier#{n}" }
  a.rating 9
end

Factory.define :game_application, :class => GameApplication, :parent => :client_application do |ga|

end

Factory.define :education_application, :class => EducationApplication, :parent => :client_application do |ea|

end
