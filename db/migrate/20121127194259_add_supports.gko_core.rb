# This migration comes from gko_core (originally 20120318222222)
class AddSupports < ActiveRecord::Migration
  def up
    # Ensure :configurations table does not exist as we change migration name
    unless table_exists?(:supports)
      create_table :supports do |t|
        t.references :owner, :polymorphic => true
        t.text :infos
      end
      add_index :supports, [:owner_id, :owner_type], :unique => true
    end
  end

  def down
    drop_table :supports
  end
end