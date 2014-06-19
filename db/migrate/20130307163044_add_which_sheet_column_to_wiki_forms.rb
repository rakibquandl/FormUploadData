class AddWhichSheetColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :which_sheet, :integer
  end
end
