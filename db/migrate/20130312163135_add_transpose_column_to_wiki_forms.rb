class AddTransposeColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :transpose, :boolean
  end
end
