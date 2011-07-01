# 
#  shared.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


module Shared
  module Mongoid
    extend ActiveSupport::Concern

    included do
      include ::Mongoid::Document
      include ::Mongoid::Timestamps
      include ::Mongoid::Paranoia
    end

    # add for mongoid_act_as_tree
    module ActTree
      extend ActiveSupport::Concern
      included do
        include ::Mongoid::Acts::Tree
        acts_as_tree
      end
    end


    module ClassMethods
      #TODO
    end#ClassMethods

    module InstanceMethods
      # 点击率
      def hits_record
        inc(:hits, 1)
      end #hits_record
    end#module InstanceMethods


    
  
  

  end#End Mongoid
end#End Shared