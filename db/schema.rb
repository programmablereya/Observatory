# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100516214340) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.text     "descriptionHTML"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "descriptionHTML"
    t.string   "permalink"
    t.integer  "parent_id"
  end

  add_index "characters", ["permalink"], :name => "index_characters_on_permalink"

  create_table "tags", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.text     "descriptionHTML"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
