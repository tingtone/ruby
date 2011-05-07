class DeviseCreateChildren < ActiveRecord::Migration
  def self.up
    create_table(:children) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :children, :email,                :unique => true
    add_index :children, :reset_password_token, :unique => true
    # add_index :children, :confirmation_token,   :unique => true
    # add_index :children, :unlock_token,         :unique => true
    # add_index :children, :authentication_token, :unique => true
  end

  def self.down
    drop_table :children
  end
end
