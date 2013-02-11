# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130122010029) do

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "favourite_listings", :force => true do |t|
    t.integer  "listing_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guests", :force => true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "invitation_sent"
    t.string   "rsvp"
    t.string   "relationship"
    t.string   "spec_food_req"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
  end

  create_table "inspirations", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
    t.integer  "position"
    t.integer  "user_id"
    t.text     "notes"
    t.string   "website_url"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "quantity",   :default => 1
    t.integer  "order_id"
  end

  create_table "listing_votes", :force => true do |t|
    t.integer  "listing_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "listing_votes", ["listing_id"], :name => "index_listing_votes_on_listing_id"
  add_index "listing_votes", ["user_id"], :name => "index_listing_votes_on_user_id"

  create_table "listings", :force => true do |t|
    t.string   "business_name"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "category"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "email"
    t.string   "website"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "address"
    t.boolean  "gmaps"
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.decimal  "price",                :precision => 8, :scale => 2
    t.string   "issue"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "user_id"
  end

  create_table "todos", :force => true do |t|
    t.text     "description"
    t.boolean  "completed",   :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "billing_address_line1"
    t.string   "billing_address_line2"
    t.string   "billing_address_city"
    t.integer  "billing_address_postcode"
    t.string   "billing_address_county"
    t.string   "shipping_address_line1"
    t.string   "shipping_address_line2"
    t.string   "shipping_address_city"
    t.integer  "shipping_address_postcode"
    t.string   "shipping_address_county"
    t.boolean  "admin",                     :default => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "type"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
    t.date     "wedding_date"
  end

end
