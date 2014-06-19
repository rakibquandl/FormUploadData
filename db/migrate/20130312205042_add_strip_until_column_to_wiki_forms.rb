class AddStripUntilColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :strip_until, :boolean
  end
end
