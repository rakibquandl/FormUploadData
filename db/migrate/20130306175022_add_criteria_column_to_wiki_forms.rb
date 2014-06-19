class AddCriteriaColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :criteria, :string
  end
end
