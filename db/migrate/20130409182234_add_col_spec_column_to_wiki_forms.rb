class AddColSpecColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :col_spec, :string
  end
end
