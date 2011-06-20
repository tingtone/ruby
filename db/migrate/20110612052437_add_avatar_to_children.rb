class AddAvatarToChildren < ActiveRecord::Migration
  def self.up
    add_column :children, :avatar_file_name,    :string
    add_column :children, :avatar_content_type, :string
    add_column :children, :avatar_file_size,    :integer
    add_column :children, :avatar_updated_at,   :datetime
  end

  def self.down
    remove_column :children, :avatar_updated_at
    remove_column :children, :avatar_file_size
    remove_column :children, :avatar_content_type
    remove_column :children, :avatar_file_name
  end
end
