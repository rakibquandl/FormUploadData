class CreateWikiForms < ActiveRecord::Migration
  def change
    create_table :wiki_forms do |t|
      t.string :url
      t.string :parser_name
      t.string :action

      t.timestamps
    end
  end
end
