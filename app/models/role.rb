# 
#  role.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Role
  include Shared::Mongoid
  
  
  #fields
  field :name
  
  validates_presence_of   :name
  validates_uniqueness_of :name
  
  references_and_referenced_in_many :forum_users, autosave: true
  
  class << self
    # ====================================================================
    # = defined Role.admin/Role.guest/Role.developer/Role.parent methods =
    # ====================================================================
    %w|admin guest parent developer|.each do |name|
      define_method "#{name}" do
        first(conditions: {name: "#{name}"})
      end
    end
    
  end
  
end