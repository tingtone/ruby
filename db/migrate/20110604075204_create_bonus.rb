class CreateBonus < ActiveRecord::Migration
  def self.up
    create_table :bonus do |t|
      t.integer :child_id
      t.integer :time

      t.timestamps
    end
  end

  def self.down
    drop_table :bonus
  end
end
