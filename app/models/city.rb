class City
  include Shared::Mongoid
  
  cache
  
  #fields
  field :name
  referenced_in :state
end