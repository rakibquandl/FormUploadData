class AddErrorMessageColumnToPreviews < ActiveRecord::Migration
  def change
    add_column :previews, :error_message, :string
  end
end
