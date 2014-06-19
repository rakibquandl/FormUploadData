class AddMoveToRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :move_to_row, :integer
  end
end
