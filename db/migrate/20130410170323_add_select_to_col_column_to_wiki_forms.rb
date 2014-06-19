class AddSelectToColColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :select_to_col, :integer
  end
end
