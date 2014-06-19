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

ActiveRecord::Schema.define(:version => 20130412151600) do

  create_table "previews", :force => true do |t|
    t.string   "source_name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "dataset_code"
    t.string   "dataset_name"
    t.string   "dataset_description"
    t.text     "preview_table"
    t.string   "source_code"
    t.string   "error_message"
  end

  create_table "wiki_forms", :force => true do |t|
    t.string   "url"
    t.string   "parser_name"
    t.string   "action"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "delimiter"
    t.integer  "which_table"
    t.string   "criteria"
    t.integer  "which_sheet"
    t.integer  "from_row"
    t.integer  "from_col"
    t.integer  "to_row"
    t.integer  "to_col"
    t.boolean  "strip_row"
    t.boolean  "strip_column"
    t.boolean  "transpose"
    t.boolean  "select_row"
    t.boolean  "select_column"
    t.boolean  "strip_until"
    t.string   "match"
    t.string   "strip_from"
    t.integer  "move_row"
    t.integer  "move_column"
    t.string   "source_code"
    t.string   "dataset_code"
    t.string   "dataset_name"
    t.string   "dataset_description"
    t.string   "source_name"
    t.string   "token"
    t.text     "col_spec"
    t.integer  "select_from_row"
    t.integer  "select_to_row"
    t.integer  "select_from_col"
    t.integer  "select_to_col"
    t.integer  "move_from_row"
    t.integer  "move_to_row"
  end

end
