# This migration comes from gko_core (originally 20120318111111)
class AddConfiguration < ActiveRecord::Migration
  def up
    # Ensure :configurations table does not exist as we change migration name
    unless table_exists?(:configurations)
      create_table :configurations do |t|
        t.references :site
        t.string :name
        t.string :type, :limit => 50
        t.timestamps
      end
    end
  end

  def down
    drop_table :configurations
  end
end