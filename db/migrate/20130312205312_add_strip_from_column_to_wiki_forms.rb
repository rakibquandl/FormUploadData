class AddStripFromColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :strip_from, :string
  end
end
