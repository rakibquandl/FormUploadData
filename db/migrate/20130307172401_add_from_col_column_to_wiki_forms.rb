class AddFromColColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :from_col, :integer
  end
end
