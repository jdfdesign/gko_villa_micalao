# This migration comes from gko_core (originally 20111120222222)
class AddLevelToSection < ActiveRecord::Migration
  def up
    unless column_exists?(:sections, :level)
      add_column :sections, :level, :integer
    end
  end

  def down
    if column_exists?(:sections, :level)
      remove_column :sections, :level
    end
  end
end