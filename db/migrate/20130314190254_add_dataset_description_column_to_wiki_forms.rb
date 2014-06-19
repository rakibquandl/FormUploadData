class AddDatasetDescriptionColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :dataset_description, :string
  end
end
