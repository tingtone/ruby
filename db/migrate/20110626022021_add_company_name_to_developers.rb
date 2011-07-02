class AddCompanyNameToDevelopers < ActiveRecord::Migration
  def self.up
    #add_column :developers, :company_name, :string
  end

  def self.down
    remove_column :developers, :company_name
  end
end
