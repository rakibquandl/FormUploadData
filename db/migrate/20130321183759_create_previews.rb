class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.string :source_name

      t.timestamps
    end
  end
end
