class Role
  include Shared::Mongoid
  
  
  #fields
  field :name
  
  references_and_referenced_in_many :roles
end