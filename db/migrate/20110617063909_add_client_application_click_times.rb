class AddClientApplicationClickTimes < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :click_times, :integer,:default=>0
  end

  def self.down
    remove_column :client_applications, :click_times
  end
end
