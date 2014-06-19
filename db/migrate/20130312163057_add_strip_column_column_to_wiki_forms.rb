class AddStripColumnColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :strip_column, :boolean
  end
end
