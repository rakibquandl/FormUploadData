class ChangeStringToText < ActiveRecord::Migration
  def up
    change_column :wiki_forms, :col_spec, :text, :limit => nil
  end

  def down
  end
end
