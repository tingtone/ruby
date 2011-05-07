class DeviseCreateDevelopers < ActiveRecord::Migration
  def self.up
    create_table(:developers) do |t|
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

    add_index :developers, :email,                :unique => true
    add_index :developers, :reset_password_token, :unique => true
    # add_index :developers, :confirmation_token,   :unique => true
    # add_index :developers, :unlock_token,         :unique => true
    # add_index :developers, :authentication_token, :unique => true
  end

  def self.down
    drop_table :developers
  end
end
