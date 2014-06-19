class WikiForm < ActiveRecord::Base
  attr_accessible :action, :parser_name, :url, :delimiter, :criteria, :which_table, :which_sheet, :from_row, :to_row, :from_col, :to_col, :strip_row , :strip_column , :transpose, :select_row, :select_column, :strip_until, :match, :strip_from, :move_row, :move_column,:source_code, :dataset_code, :dataset_name, :dataset_description,:source_name,:token, :col_spec, :select_from_row, :select_to_row, :select_from_col, :select_to_col, :move_from_row, :move_to_row
  validates :parser_name, :url, :presence => true
  validates_format_of :url, :with => /^(http|https|www):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates_numericality_of :from_row, :only_integer => true , :allow_blank => true
  validates_numericality_of :to_row,   :only_integer => true , :allow_blank => true
  validates_numericality_of :select_from_row, :only_integer => true , :allow_blank => true
  validates_numericality_of :select_to_row,   :only_integer => true , :allow_blank => true
  validates_numericality_of :move_from_row, :only_integer => true , :allow_blank => true
  validates_numericality_of :move_to_row,   :only_integer => true , :allow_blank => true
  validates_numericality_of :select_from_col, :only_integer => true , :allow_blank => true
  validates_numericality_of :select_to_col,   :only_integer => true , :allow_blank => true


  validates_numericality_of :to_col,   :only_integer => true , :allow_blank => true
  validates_numericality_of :from_col, :only_integer => true , :allow_blank => true
  validates_format_of :strip_from, :with => /[a-zA-Z]/ ,       :allow_blank => true
  validates_format_of :match, :with => /[a-zA-Z0-9]/ ,         :allow_blank => true
  validates :dataset_code , :dataset_name , :dataset_description ,:source_code , :source_name, :token, :presence => true

end
