class Search
  include Mongoid::Document
  include Mongoid::Timestamps

  cache

  #fields
  field :keywords
  
  
end