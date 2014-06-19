class AddPreviewTableColumnToPreviews < ActiveRecord::Migration
  def change
    add_column :previews, :preview_table, :string
  end
end
