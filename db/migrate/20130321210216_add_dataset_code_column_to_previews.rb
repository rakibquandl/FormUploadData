class AddDatasetCodeColumnToPreviews < ActiveRecord::Migration
  def change
    add_column :previews, :dataset_code, :string
  end
end
