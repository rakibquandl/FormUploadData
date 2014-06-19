class AddDatasetNameColumnToPreviews < ActiveRecord::Migration
  def change
    add_column :previews, :dataset_name, :string
  end
end
