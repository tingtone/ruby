class AddRatingToClientApplications < ActiveRecord::Migration
  def self.up
    add_column :client_applications, :rating, :integer
  end

  def self.down
    remove_column :client_applications, :rating
  end
end
