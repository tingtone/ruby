class Country
  include Shared::Mongoid
  
  cache
  
  #fields
  field :name
  
  references_many :states
end