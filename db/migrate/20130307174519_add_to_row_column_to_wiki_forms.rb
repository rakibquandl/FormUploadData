class AddToRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :to_row, :integer
  end
end
