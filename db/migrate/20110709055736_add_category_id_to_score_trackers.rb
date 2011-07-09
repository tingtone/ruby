class AddCategoryIdToScoreTrackers < ActiveRecord::Migration
  def self.up
    add_column :score_trackers, :category_id, :integer
  end

  def self.down
    remove_column :score_trackers, :category_id
  end
end
