# 
#  mongoid_count_cache.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


# ===================================
# include Mongoid::Relations::CounterCache
# default:
# referenced_in :person, :inverse_of => :posts, :counter_cache => true
# custom:
# referenced_in :person, :inverse_of => :posts, :counter_cache => :posts_count 
# ===================================

module Mongoid
  module Relations
    module CounterCache
      extend ActiveSupport::Concern
      module ClassMethods

        def counter_cache(metadata)
          if metadata.counter_cache?
            counter_name = if metadata.counter_cache.to_s != 'true'
              metadata.counter_cache.to_s
            else 
              "#{metadata.inverse_of}_count" 
            end

            set_callback(:create, :after) do |document|
              relation = document.send(metadata.name)
              if relation
                relation.inc(counter_name.to_sym, 1) if relation.class.fields.keys.include?(counter_name)
              end
            end

            set_callback(:destroy, :after) do |document|
              relation = document.send(metadata.name)
              if relation && relation.class.fields.keys.include?(counter_name)
                relation.inc(counter_name.to_sym, -1)
              end
            end

          end
        end

        def referenced_in(name, options = {}, &block)
          characterize(name, Referenced::In, options, &block).tap do |meta|
            relate(name, meta)
            reference(meta)
            autosave(meta)
            counter_cache(meta) # 計數器
            validates_relation(meta)
          end
        end
        alias :belongs_to_related :referenced_in
        alias :belongs_to :referenced_in
      end
    end
  end
end