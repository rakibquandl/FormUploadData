class AddDatasetDescriptionColumnToPreviews < ActiveRecord::Migration
  def change
    add_column :previews, :dataset_description, :string
  end
end
