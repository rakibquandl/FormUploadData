class AddDelimiterColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :delimiter, :string
  end
end
