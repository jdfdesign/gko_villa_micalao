# This migration comes from gko_auth (originally 20111123000000)
# Adjust user to be compatible with spree shop

class AdjustForShop < ActiveRecord::Migration
  def up
    unless table_exists?(:users)
      create_table "users", :force => true do |t|
        t.string "name"
      end
    end
    unless table_exists?(:roles)
      create_table "roles", :force => true do |t|
        t.string "name"
      end
    end
    unless table_exists?(:roles_users)
      create_table "roles_users", :id => false, :force => true do |t|
        t.integer "role_id"
        t.integer "user_id"
      end

      add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
      add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"
    end

    add_column :users, :password_salt, :string unless column_exists?(:users, :password_salt)
    #add_column :users, :remember_token, :string
    unless column_exists?(:users, :persistence_token)
      add_column :users, :persistence_token, :string
      add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
    end
    add_column :users, :perishable_token, :string unless column_exists?(:users, :perishable_token)
    add_column :users, :failed_attempts, :integer, :default => 0, :null => false unless column_exists?(:users, :failed_attempts)
    add_column :users, :last_request_at, :datetime unless column_exists?(:users, :last_request_at)
    add_column :users, :login, :string unless column_exists?(:users, :login)
    add_column :users, :authentication_token, :string unless column_exists?(:users, :authentication_token)
    add_column :users, :unlock_token, :string unless column_exists?(:users, :unlock_token)
    add_column :users, :locked_at, :datetime unless column_exists?(:users, :locked_at)
    #add_column :users, :api_key, :string, :limit => 40

    remove_column :users, :roles if column_exists?(:users, :roles)

    unless table_exists?(:tokenized_permissions)
      create_table "tokenized_permissions", :force => true do |t|
        t.integer "permissable_id"
        t.string "permissable_type"
        t.string "token"
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index "tokenized_permissions", ["permissable_id", "permissable_type"], :name => "index_tokenized_name_and_type"
    end
    drop_table :permission_groups if table_exists?(:tokenized_permissions)
    drop_table :groups if table_exists?(:groups)
    drop_table :permissions if table_exists?(:permissions)
    if column_exists?(:users, :group_id)
      remove_index :users, :group_id
      remove_column :users, :group_id
    end
  end

  def down
    add_column :users, :roles, :string if column_exists?(:users, :roles)
    remove_table "roles" if table_exists?(:roles)
    remove_table "roles_users" if table_exists?(:roles_users)
    remove_column :users, :password_salt if column_exists?(:users, :password_salt)
    #remove_column :users, :remember_token
    remove_column :users, :persistence_token if column_exists?(:users, :persistence_token)
    remove_column :users, :perishable_token if column_exists?(:users, :perishable_token)
    remove_column :users, :failed_attempts if column_exists?(:users, :failed_attempts)
    remove_column :users, :last_request_at if column_exists?(:users, :last_request_at)
    remove_column :users, :login, :string if column_exists?(:users, :login)
    remove_column :users, :authentication_token if column_exists?(:users, :authentication_token)
    remove_column :users, :unlock_token if column_exists?(:users, :unlock_token)
    remove_column :users, :locked_at if column_exists?(:users, :locked_at)
    #remove_column :users, :api_key
    remove_table "tokenized_permissions" if table_exists?(:tokenized_permissions)
  end
end