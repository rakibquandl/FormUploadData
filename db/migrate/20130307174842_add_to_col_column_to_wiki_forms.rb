class AddToColColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :to_col, :integer
  end
end
