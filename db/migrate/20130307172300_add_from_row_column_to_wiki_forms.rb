class AddFromRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :from_row, :integer
  end
end
