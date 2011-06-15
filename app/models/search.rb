class Search
  include Mongoid::Document
  include Mongoid::Timestamps

  cache

  #fields
  field :keywords
  field :typee
  
  SEARCH_TYPE = %w|Topic User App|
end