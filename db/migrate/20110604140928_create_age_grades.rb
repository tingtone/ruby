class CreateAgeGrades < ActiveRecord::Migration
  def self.up
    create_table :age_grades do |t|
      t.integer :age
      t.integer :grade_id

      t.timestamps
    end
  end

  def self.down
    drop_table :age_grades
  end
end
