class AddMoveFromRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :move_from_row, :integer
  end
end
