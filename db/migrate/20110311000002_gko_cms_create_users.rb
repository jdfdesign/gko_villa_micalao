require 'devise'
require 'devise/orm/active_record'

class GkoCmsCreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.references :account

      t.database_authenticatable
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps

      t.string :roles
      t.string :username, :limit => 60
      t.string :firstname, :limit => 60
      t.string :lastname, :limit => 60
      t.string :preferred_language, :limit => 5
      t.string :timezone
      t.integer :site_registrations_count, :default => 0

    end

    add_index :users, :account_id

    add_column :sites, :site_registrations_count, :integer, :default => 0

    create_table :site_registrations do |t|
      t.integer :user_id
      t.integer :site_id
    end

    add_index :site_registrations, [:user_id, :site_id]
  end

  def self.down
    remove_column :sites, :site_registrations_count
    remove_index :users, :account_id
    drop_table :users
    remove_index :site_registrations, [:user_id, :site_id]
    drop_table :site_registrations
  end
end