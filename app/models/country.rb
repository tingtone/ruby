class Country
  include Mongoid::Document
  include Mongoid::Timestamps
  
  cache
  
  #fields
  field :name
  
  references_many :states
end