class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.string :course
      t.integer :grade_id
      t.integer :score
      t.integer :child_id

      t.timestamps
    end
  end

  def self.down
    drop_table :achievements
  end
end
