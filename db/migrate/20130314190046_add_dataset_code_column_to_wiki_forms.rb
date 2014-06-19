class AddDatasetCodeColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :dataset_code, :string
  end
end
