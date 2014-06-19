class AddSourceNameColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :source_name, :string
  end
end
