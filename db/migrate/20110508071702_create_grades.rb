class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.string :name
      t.integer :min_score
      t.integer :max_score

      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end
