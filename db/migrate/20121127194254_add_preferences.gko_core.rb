# This migration comes from gko_core (originally 20111208111111)
class AddPreferences < ActiveRecord::Migration
  def up
    unless table_exists?(:preferences)
      create_table :preferences, :force => true do |t|
        t.string :key, :null => false
        t.string :value_type, :limit => 50
        t.string :value
        t.timestamps
      end
      add_index :preferences, :key, :unique => true
    end
  end

  def down
    remove_table :preferences
  end
end