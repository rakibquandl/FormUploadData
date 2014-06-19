class AddMoveColumnColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :move_column, :integer
  end
end
