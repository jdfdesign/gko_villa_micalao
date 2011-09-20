# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110828111111) do

  create_table "accounts", :force => true do |t|
    t.string   "reference",  :limit => 40
    t.string   "nickname"
    t.string   "status",     :limit => 40
    t.string   "type",       :limit => 40
    t.datetime "deleted_at"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_translations", :force => true do |t|
    t.integer  "content_id"
    t.string   "locale"
    t.text     "body"
    t.string   "slug"
    t.string   "meta_title"
    t.text     "meta_description"
    t.string   "title"
    t.text     "meta_keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_translations", ["content_id"], :name => "index_content_translations_on_content_id"

  create_table "contents", :force => true do |t|
    t.integer  "site_id"
    t.integer  "section_id"
    t.integer  "account_id"
    t.integer  "author_id"
    t.string   "type"
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.datetime "published_at"
    t.string   "layout",           :limit => 40
    t.string   "meta_title"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.text     "options"
    t.string   "author_name",      :limit => 120
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "globalized",                      :default => 0
  end

  add_index "contents", ["section_id"], :name => "index_contents_on_section_id"
  add_index "contents", ["site_id"], :name => "index_contents_on_site_id"
  add_index "contents", ["slug"], :name => "index_contents_on_slug"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso3",           :limit => 3
    t.string   "iso",            :limit => 2
    t.string   "printable_name"
    t.integer  "numcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "restricted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_assignments", :force => true do |t|
    t.integer  "position",                      :default => 1, :null => false
    t.integer  "image_id",                                     :null => false
    t.integer  "attachable_id",                                :null => false
    t.string   "attachable_type", :limit => 40,                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_assignments", ["attachable_id", "attachable_type"], :name => "index_image_assignments_on_attachable_id_and_attachable_type"
  add_index "image_assignments", ["image_id"], :name => "index_image_assignments_on_image_id"

  create_table "image_translations", :force => true do |t|
    t.integer  "image_id"
    t.string   "locale"
    t.string   "alt"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_translations", ["image_id"], :name => "index_image_translations_on_image_id"

  create_table "images", :force => true do |t|
    t.string   "title",                   :limit => 100
    t.string   "alt"
    t.integer  "account_id"
    t.integer  "author_id"
    t.integer  "site_id"
    t.integer  "image_assignments_count",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.integer  "globalized",                             :default => 0
  end

  add_index "images", ["account_id"], :name => "index_images_on_account_id"
  add_index "images", ["author_id"], :name => "index_images_on_author_id"
  add_index "images", ["site_id"], :name => "index_images_on_site_id"

  create_table "inquiries", :force => true do |t|
    t.string   "type"
    t.string   "confirmation_code", :limit => 40
    t.string   "to_email"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.boolean  "open",                            :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "confirmed_at"
    t.boolean  "spam",                            :default => false
    t.text     "options"
    t.integer  "site_id"
  end

  add_index "inquiries", ["site_id"], :name => "index_inquiries_on_site_id"

  create_table "mail_methods", :force => true do |t|
    t.integer  "site_id"
    t.string   "environment"
    t.boolean  "active",                 :default => true
    t.boolean  "enable_mail_delivery",   :default => true
    t.string   "mail_host"
    t.string   "mail_domain"
    t.integer  "mail_port",              :default => 25
    t.string   "mail_auth_type"
    t.string   "smtp_username"
    t.string   "smtp_password"
    t.string   "secure_connection_type"
    t.string   "mails_from"
    t.string   "mail_bcc"
    t.string   "intercept_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_methods", ["site_id"], :name => "index_mail_methods_on_site_id"

  create_table "permission_groups", :force => true do |t|
    t.integer "group_id"
    t.integer "permission_id"
  end

  add_index "permission_groups", ["group_id", "permission_id"], :name => "index_permission_groups_on_group_id_and_permission_id"

  create_table "permissions", :force => true do |t|
    t.string   "plugin_name"
    t.string   "path"
    t.string   "action"
    t.boolean  "restricted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "section_translations", :force => true do |t|
    t.integer  "section_id"
    t.string   "locale"
    t.string   "title_addon"
    t.string   "path"
    t.text     "body"
    t.string   "redirect_url"
    t.string   "menu_title"
    t.string   "slug"
    t.string   "meta_title"
    t.text     "meta_description"
    t.string   "title"
    t.text     "meta_keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "section_translations", ["section_id"], :name => "index_section_translations_on_section_id"

  create_table "sections", :force => true do |t|
    t.integer  "site_id"
    t.integer  "parent_id"
    t.integer  "link_id"
    t.string   "link_type"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "type"
    t.string   "name"
    t.string   "slug"
    t.string   "path"
    t.text     "options"
    t.string   "title"
    t.string   "layout"
    t.text     "body"
    t.string   "meta_title"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.string   "redirect_url"
    t.string   "title_addon"
    t.datetime "published_at"
    t.boolean  "hidden",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "menu_title"
    t.integer  "globalized",       :default => 0
  end

  add_index "sections", ["link_id", "link_type"], :name => "index_sections_on_link_id_and_link_type"
  add_index "sections", ["parent_id"], :name => "index_sections_on_parent_id"
  add_index "sections", ["site_id"], :name => "index_sections_on_site_id"

  create_table "settings", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable",             :default => true
    t.string   "scoping"
    t.boolean  "restricted",              :default => false
    t.string   "callback_proc_as_string"
    t.string   "form_value_type",         :default => "text_area", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["name"], :name => "index_settings_on_name"
  add_index "settings", ["site_id"], :name => "index_settings_on_site_id"

  create_table "site_registrations", :force => true do |t|
    t.integer "user_id"
    t.integer "site_id"
  end

  add_index "site_registrations", ["user_id", "site_id"], :name => "index_site_registrations_on_user_id_and_site_id"

  create_table "site_translations", :force => true do |t|
    t.integer  "site_id"
    t.string   "locale"
    t.string   "meta_title"
    t.string   "subtitle"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_translations", ["site_id"], :name => "index_site_translations_on_site_id"

  create_table "sites", :force => true do |t|
    t.integer  "account_id"
    t.string   "host"
    t.string   "title"
    t.string   "meta_title"
    t.string   "subtitle"
    t.string   "timezone"
    t.string   "locales",                  :limit => 17
    t.boolean  "public",                                 :default => true
    t.text     "options"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_registrations_count",               :default => 0
    t.integer  "globalized",                             :default => 0
    t.text     "plugins"
  end

  add_index "sites", ["account_id"], :name => "index_sites_on_account_id"
  add_index "sites", ["host"], :name => "index_sites_on_host", :unique => true

  create_table "users", :force => true do |t|
    t.integer  "account_id"
    t.string   "email",                                   :default => "", :null => false
    t.string   "encrypted_password",       :limit => 128, :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "roles"
    t.string   "username",                 :limit => 60
    t.string   "firstname",                :limit => 60
    t.string   "lastname",                 :limit => 60
    t.string   "preferred_language",       :limit => 5
    t.string   "timezone"
    t.integer  "site_registrations_count",                :default => 0
    t.integer  "group_id"
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"
  add_index "users", ["group_id"], :name => "index_users_on_group_id"

end
