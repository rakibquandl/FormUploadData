class AddWhichTableColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :which_table, :integer
  end
end
