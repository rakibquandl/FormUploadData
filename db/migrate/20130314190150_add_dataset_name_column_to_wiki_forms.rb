class AddDatasetNameColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :dataset_name, :string
  end
end
