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
      #TODO
    end#module InstanceMethods


    
  
  

  end#End Mongoid
end#End Shared