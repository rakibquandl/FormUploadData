class AddSelectToRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :select_to_row, :integer
  end
end
