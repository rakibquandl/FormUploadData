class AddSelectFromColColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :select_from_col, :integer
  end
end
