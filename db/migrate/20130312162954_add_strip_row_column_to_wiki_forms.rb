class AddStripRowColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :strip_row, :boolean
  end
end
