class City
  include Mongoid::Document
  include Mongoid::Timestamps
  
  cache
  
  #fields
  field :name
  referenced_in :state
end