class State
  include Mongoid::Document
  include Mongoid::Timestamps
  
  cache
  
  #fields
  field :name
  referenced_in :country
  references_many :cities
end