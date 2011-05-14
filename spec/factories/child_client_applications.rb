Factory.define :time_tracker do |cca|
  cca.association :child
  cca.association :client_application
  cca.time 1000
end
