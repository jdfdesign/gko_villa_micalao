# This migration comes from gko_core (originally 20120403000000)
class AddLogoToSite < ActiveRecord::Migration
  def up
    add_column :sites, :logo_mime_type, :string unless column_exists?(:sites, :logo_mime_type)
    add_column :sites, :logo_name, :string unless column_exists?(:sites, :logo_name)
    add_column :sites, :logo_size, :integer unless column_exists?(:sites, :logo_size)
    add_column :sites, :logo_width, :integer unless column_exists?(:sites, :logo_width)
    add_column :sites, :logo_height, :integer unless column_exists?(:sites, :logo_height)
    add_column :sites, :logo_uid, :string unless column_exists?(:sites, :logo_uid)
    add_column :sites, :logo_ext, :string unless column_exists?(:sites, :logo_ext)
  end

  def down
    remove_column :sites, :logo_mime_type
    remove_column :sites, :logo_name
    remove_column :sites, :logo_size
    remove_column :sites, :logo_width
    remove_column :sites, :logo_height
    remove_column :sites, :logo_uid
    remove_column :sites, :logo_ext
  end
end