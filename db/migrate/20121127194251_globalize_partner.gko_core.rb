# This migration comes from gko_core (originally 20110801000003)
class GlobalizePartner < ActiveRecord::Migration
  def up
    unless table_exists?(:partner_translations)
      Partner.create_translation_table!({
                                            :body => :text
                                        }, {:migrate_data => true})
    end
  end


  def down
    Partner.drop_translation_table! :migrate_data => true
  end
end    
