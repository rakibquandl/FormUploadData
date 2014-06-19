class Preview < ActiveRecord::Base
  attr_accessible :source_name, :dataset_code, :dataset_name, :dataset_description, :preview_table, :source_code, :error_message
end
