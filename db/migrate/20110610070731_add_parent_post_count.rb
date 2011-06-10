class AddParentPostCount < ActiveRecord::Migration
  def self.up
    add_column :parents, :posts_count, :integer, :default => 0

#    Parent.reset_column_information
#    Parent.find(:all).each do |p|
#      p.update_attribute :posts_count, p.posts.length
#    end
  end

  def self.down
    remove_column :parents, :posts_count
  end
end
