class AddMatchColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :match, :string
  end
end
