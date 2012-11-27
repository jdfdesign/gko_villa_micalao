# This migration comes from gko_core (originally 20110801000002)
class GkoPartnerCreateTables < ActiveRecord::Migration
  def up
    unless table_exists?(:partners)
      create_table :partners do |t|
        t.string :title
        t.text :body
        t.string :url
        t.integer :site_id
        t.integer :section_id

        t.string :image_mime_type
        t.string :image_name
        t.integer :image_size
        t.integer :image_width
        t.integer :image_height
        t.string :image_uid
        t.string :image_ext
        t.timestamps
      end
      add_index :partners, :site_id
      add_index :partners, :section_id
    end
  end

  def down
    drop_table :partners
  end
end