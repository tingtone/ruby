Factory.define :parent_client_application do |pca|
  pca.association :parent
  pca.association :client_application
end
