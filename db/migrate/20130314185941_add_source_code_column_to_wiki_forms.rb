class AddSourceCodeColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :source_code, :string
  end
end
