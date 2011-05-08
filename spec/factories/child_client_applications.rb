Factory.define :child_client_application do |cca|
  cca.association :child
  cca.association :client_application
  cca.time 1000
end
