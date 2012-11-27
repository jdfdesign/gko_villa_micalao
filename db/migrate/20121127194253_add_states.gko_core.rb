# This migration comes from gko_core (originally 20111130111111)
class AddStates < ActiveRecord::Migration
  def self.up
    unless table_exists?(:states)
      create_table "states", :force => true do |t|
        t.string "name"
        t.string "abbr"
        t.integer "country_id"
      end

      add_index "states", ["country_id"], :name => "index_states_on_country_id"
    end
  end

  def self.down
    remove_table "states"
  end
end