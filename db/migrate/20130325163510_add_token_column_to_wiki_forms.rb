class AddTokenColumnToWikiForms < ActiveRecord::Migration
  def change
    add_column :wiki_forms, :token, :string
  end
end
