class State
  include Shared::Mongoid
  
  cache
  
  #fields
  field :name
  referenced_in :country
  references_many :cities
end