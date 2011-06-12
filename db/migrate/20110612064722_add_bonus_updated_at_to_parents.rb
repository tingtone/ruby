class AddBonusUpdatedAtToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :bonus_updated_at, :datetime
  end

  def self.down
    remove_column :parents, :bonus_updated_at
  end
end
