class AddSourceCodeColumnToPreviews < ActiveRecord::Migration
  def change
    add_column :previews, :source_code, :string
  end
end
