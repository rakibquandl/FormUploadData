class ChangeColumn < ActiveRecord::Migration
  def up
    change_column :previews, :preview_table, :text, :limit => nil
  end

  def down
    change_column :previews, :preview_table, :text, :limit => 255
  end
end
