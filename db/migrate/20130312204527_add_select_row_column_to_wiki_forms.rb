class AddSelectRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :select_row, :boolean
  end
end
