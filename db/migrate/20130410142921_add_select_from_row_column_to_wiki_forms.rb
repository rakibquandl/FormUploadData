class AddSelectFromRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :select_from_row, :integer
  end
end
