class AddMoveRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :move_row, :integer
  end
end
