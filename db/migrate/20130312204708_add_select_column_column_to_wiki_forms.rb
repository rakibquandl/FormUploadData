class AddSelectColumnColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :select_column, :boolean
  end
end
