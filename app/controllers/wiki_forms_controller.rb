require 'rubygems'
require 'pipeline'
require 'wikimeta'
require 'open-uri'
require 'nokogiri'
require 'roo'

class WikiFormsController < ApplicationController

  include Wikimeta

  respond_to :html, :js

  def index
    @wiki_forms = WikiForm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wiki_forms }
    end
  end

  def show
    @wiki_form = WikiForm.find(params[:id])

    @dataset_code = Preview.last.dataset_code
    @source_code = Preview.last.source_code

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wiki_form }
    end
  end

  def content

    result = []
    data_url =  params[:input_url]
    req = open(data_url)

    result[0] = req.content_type

    if req.content_type == "text/html"
      doc = Nokogiri::HTML(req)
      tables = doc.css('table')

      numtables = tables.to_a.length
      index = Array.new(numtables) {|i| i}

      if index.length == 1
        #puts "table number is: #{index[0]}"
        result[1] = index[0]
      else
        #determines number to character ratio of each table and puts it in a hash
        table_ratio_hash = Hash.new
        index.each_index do |i|
          the_table = tables[index[i]]
          the_table.css('table').each {|subtable| subtable.remove}
          content_string = the_table.content.gsub(/\s/,'')
          totalchars = content_string.length
          numchars = 0
          #check each character, add 1 to numchars if it is a digit
          0.upto(totalchars-1) do |j|
            numchars += 1 if /[[:digit:]]/ =~ content_string[j]
          end
          ratio = Float(numchars)/(Float(totalchars)+0.01)
          table_ratio_hash[index[i]] = ratio
        end
        index.sort! {|a,b| table_ratio_hash[b] <=> table_ratio_hash[a]}
        result[1] = index[0]
      end

      #guess column spec for html

      table_headers = ""
      table = tables[result[1]]

      table.css('th').each_with_index do|th,i|

        if i == 0
          table_headers = "#{th.text}"

        elsif i == -1
          table_headers += ",#{th.text}"

        else
          table_headers += ",#{th.text}"

        end

      end

      result[2] = table_headers


    elsif req.content_type == "text/xls" or req.content_type == "application/vnd.ms-excel"

      header = []
      rspreadsheet  = Roo::Excel.new(data_url)
      result[1] =  rspreadsheet.to_csv

      rspreadsheet.default_sheet = rspreadsheet.sheets.first

      rspreadsheet.each_with_index do |line,i|
        header =  line if i == 0
        break
      end
      result[2] = header

    elsif req.content_type == "text/csv"

      a = []
      header = []
      CSV.new(open(data_url)).each_with_index do |csv_data,i|

        header = csv_data if i == 0
        a << "\n"
        a <<  csv_data
        a << "\n"

      end
      result[1] = a
      result[2] = header

    end

    render :json => result
  end

  def new
    @wiki_form = WikiForm.new

  end

  def edit
    @wiki_form = WikiForm.find(params[:id])
  end

  def create

    params_hash = params[:wiki_form]
    parser = params_hash[:parser_name]
    delimiter = params_hash[:delimiter]
    from_row =  params_hash[:from_row]
    to_row = params_hash[:to_row]
    select_from_row =  params_hash[:select_from_row]
    select_to_row = params_hash[:select_to_row]
    move_from_row =  params_hash[:move_from_row]
    move_to_row = params_hash[:move_to_row]
    select_from_col =  params_hash[:select_from_col]
    select_to_col = params_hash[:select_to_col]
    from_col = params_hash[:from_col]
    to_col = params_hash[:to_col]
    which_sheet = params_hash[:which_sheet]
    criteria = params_hash[:criteria]
    which_table = params_hash[:which_table]
    which_table = which_table.to_i
    match = params_hash[:match]
    strip_from = params_hash[:strip_from]

    url = params_hash[:url]
    token = params_hash[:token]
    host = url.split("/")[2]
    #puts "host : #{host}"
    source_code = params_hash[:source_code]
    source_name = params_hash[:source_name]
    #puts "source name : #{source_name}"
    dataset_code = params_hash[:dataset_code]
    dataset_name = params_hash[:dataset_name]
    dataset_description = params_hash[:dataset_description]
    col_spec = params_hash[:col_spec]
    #col_spec = col_spec.gsub(" ","").gsub("\n","").gsub("\r","").gsub('"','')
    col_spec = col_spec.gsub('"','')

    error_message = ""

    ##actions

    strip_row = params[:strip_row]
    strip_column = params[:strip_column]
    transpose = params[:transpose]
    select_row = params[:select_row]
    select_column = params[:select_column]
    strip_until = params[:strip_until]
    move_row = params[:move_row]
    move_column = params[:move_column]

    delimiter_hash = {"comma" => "," , "tab" => "\t" , "semicolon" => ";"}


    if url.size > 0  and parser.size > 0

     if params[:preview_dataset]

         importer = Importer.new({
                                  #:token => 'uzTCmFhg24dZzCSNyATo',
                                  :token => token,
                                  :environment => 'production',
                                  :verbose => true,
                                  :mode => 'review'
                              })
     else

         importer = Importer.new({
                                   :token => token,
                                   :environment => 'production',
                                   :verbose => true,
                                   :mode => 'send'
                               })

     end

     begin

       importer.import_source(
           :code => source_code,
           :name => source_name,
           :host => host
       )

     rescue Exception => e
       error_message = e.to_s+"\n"

     end

     puts "token is : #{token}"
     puts "Error Message : #{error_message}"
     import_spec = ImportSpec.new()

      if parser == "html"

        import_spec.add_parser(:html, {:which => which_table})

        if strip_row and !from_row.include? ","
          import_spec.add_action(:strip_rows, {:rows => [from_row.to_i..to_row.to_i]})
        elsif strip_row and from_row.include? ","
          import_spec.add_action(:strip_rows, {:rows => from_row.split(",").map {|i| i.to_i}})
        end

        if strip_column and !strip_column.include? ","
          import_spec.add_action(:strip_columns, {:columns => [from_col.to_i..to_col.to_i]})
        elsif strip_column and strip_column.include? ","
          import_spec.add_action(:strip_columns, {:columns => from_col.split(",").map {|i| i.to_i}})
        end

        import_spec.add_action(:transpose)                                                    if transpose

        if select_row and !select_from_row.include? ","
          import_spec.add_action(:select_rows, {:rows => [select_from_row.to_i..select_to_row.to_i]})
        elsif select_row and select_from_row.include? ","
          import_spec.add_action(:select_rows, {:rows => select_from_row.split(",").map {|i| i.to_i}})
        end

        if select_column and !select_from_col.include? ","
          import_spec.add_action(:select_columns, {:columns => [select_from_col.to_i..select_to_col.to_i]})
        elsif select_column and select_from_row.include? ","
          import_spec.add_action(:select_columns, {:columns => select_from_col.split(",").map {|i| i.to_i}})
        end

        import_spec.add_action(:strip_until, {:match => match , :from => strip_from})         if strip_until

      elsif  parser == "csv"

        import_spec.add_parser(:csv, {:delimiter => delimiter_hash[delimiter]})

        if strip_row and !from_row.include? ","
          import_spec.add_action(:strip_rows, {:rows => [from_row.to_i..to_row.to_i]})
        elsif strip_row and from_row.include? ","
          import_spec.add_action(:strip_rows, {:rows => from_row.split(",").map {|i| i.to_i}})
        end

        if strip_column and !strip_column.include? ","
          import_spec.add_action(:strip_columns, {:columns => [from_col.to_i..to_col.to_i]})
        elsif strip_column and strip_column.include? ","
          import_spec.add_action(:strip_columns, {:columns => from_col.split(",").map {|i| i.to_i}})
        end

        import_spec.add_action(:transpose)                                                    if transpose

        if select_row and !select_from_row.include? ","
          import_spec.add_action(:select_rows, {:rows => [select_from_row.to_i..select_to_row.to_i]})
        elsif select_row and select_from_row.include? ","
          import_spec.add_action(:select_rows, {:rows => select_from_row.split(",").map {|i| i.to_i}})
        end

        if select_column and !select_from_col.include? ","
          import_spec.add_action(:select_columns, {:columns => [select_from_col.to_i..select_to_col.to_i]})
        elsif select_column and select_from_row.include? ","
          import_spec.add_action(:select_columns, {:columns => select_from_col.split(",").map {|i| i.to_i}})
        end

        import_spec.add_action(:strip_until, {:match => match , :from => strip_from})         if strip_until

      elsif  parser == "xls"

        import_spec.add_parser(:excel, {:worksheet => which_sheet.to_i})

        if strip_row and !from_row.include? ","
          import_spec.add_action(:strip_rows, {:rows => [from_row.to_i..to_row.to_i]})
        elsif strip_row and from_row.include? ","
          import_spec.add_action(:strip_rows, {:rows => from_row.split(",").map {|i| i.to_i}})
        end

        if strip_column and !strip_column.include? ","
          import_spec.add_action(:strip_columns, {:columns => [from_col.to_i..to_col.to_i]})
        elsif strip_column and strip_column.include? ","
          import_spec.add_action(:strip_columns, {:columns => from_col.split(",").map {|i| i.to_i}})
        end

        import_spec.add_action(:transpose)                                                   if transpose

        if select_row and !select_from_row.include? ","
          import_spec.add_action(:select_rows, {:rows => [select_from_row.to_i..select_to_row.to_i]})
        elsif select_row and select_from_row.include? ","
          import_spec.add_action(:select_rows, {:rows => select_from_row.split(",").map {|i| i.to_i}})
        end

        if select_column and !select_from_col.include? ","
          import_spec.add_action(:select_columns, {:columns => [select_from_col.to_i..select_to_col.to_i]})
        elsif select_column and select_from_row.include? ","
          import_spec.add_action(:select_columns, {:columns => select_from_col.split(",").map {|i| i.to_i}})
        end

        import_spec.add_action(:strip_until, {:match => match , :from => strip_from})         if strip_until

      end

      puts "Import Spec : #{import_spec.inspect}"

      code = dataset_code
      name = dataset_name
      desc = dataset_description

      puts "code is #{code}"
      puts name
      puts desc
      puts "col spec : #{col_spec}"

     if col_spec
       dataset = Dataset.new(
           :source => importer.source,
           :code => code,
           :name => name,
           :description => desc,
           :import_url => url,
           :import_spec => import_spec,
           :column_spec => col_spec.split(",")
       )

     else

       dataset = Dataset.new(
           :source => importer.source,
           :code => code,
           :name => name,
           :description => desc,
           :import_url => url,
           :import_spec => import_spec
       )

     end

      if  params[:preview_dataset]

        begin
          temp = importer.import_dataset(dataset)
          puts "temp result of review : #{temp.inspect}"
        rescue Exception => e
          error_message += e.to_s+"\n"
        end
      else
        importer.import_dataset(dataset)
      end

  end

    @wiki_form = WikiForm.new(params[:wiki_form])
    @wiki_form.update_attributes(:strip_row => strip_row , :strip_column => strip_column , :transpose => transpose, :select_row => select_row, :select_column => select_column, :strip_until => strip_until, :move_row => move_row, :move_column => move_column, :source_code => source_code, :dataset_code => dataset_code, :dataset_name => dataset_name, :dataset_description => dataset_description, :source_name => source_name)

    if params[:preview_dataset]

      @preview = Preview.create(:source_name => source_name , :dataset_code => dataset_code , :dataset_name => dataset_name , :dataset_description => dataset_description , :preview_table => temp, :source_code => source_code, :error_message => error_message)

      #@preview.save and flash[:notice] = "Preview has been created!"
      respond_with(@preview)


   else

      respond_to do |format|
        if @wiki_form.save
          format.js { render :js => "window.location.replace('#{wiki_form_path(@wiki_form)}');" }

        end
      end

   end

      #puts "strip_row : #{strip_row}"         unless strip_row.nil?
      #puts "strip_column : #{strip_column}"   unless strip_column.nil?
      #puts "transpose : #{transpose}"         unless transpose.nil?
      #puts "select_row : #{select_row}"       unless select_row.nil?
      #puts "select column : #{select_column}" unless select_column.nil?
      #puts "strip until : #{strip_until}"     unless strip_until.nil?
      #puts "move row : #{move_row}"           unless move_row.nil?
      #puts "move column : #{move_column}"     unless move_column.nil?
      #
      #puts "match : #{match}"                 unless match.nil?
      #puts "strip from : #{strip_from}"       unless strip_from.nil?
      #
      #puts "url : #{url}"
      #puts "source_code : #{source_code}"
      #puts "dataset_code : #{dataset_code}"
      #puts "dataset_name : #{dataset_name}"
      #puts "dataset_description : #{dataset_description}"
      #
      #puts "parser : #{parser}"               unless parser.size < 1
      #puts "delimiter : #{delimiter}"         unless delimiter.size < 1
      #puts "from_row : #{from_row}"           unless from_row.size < 1
      ##puts "to_row : #{to_row}"               unless to_row.size < 1
      #puts "from_col : #{from_col}"           unless from_col.size < 1
      #puts "to_col : #{to_col}"               unless to_col.size < 1
      #puts "which_sheet : #{which_sheet}"     unless which_sheet.size < 1
      #puts "which_table : #{which_table}"     unless which_table.size < 1
      #puts "criteria : #{criteria}"           unless criteria.size < 1

  end

  # PUT /wiki_forms/1
  # PUT /wiki_forms/1.json
  def update
    @wiki_form = WikiForm.find(params[:id])

    respond_to do |format|
      if @wiki_form.update_attributes(params[:wiki_form])
        format.html { redirect_to @wiki_form, notice: 'Wiki form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wiki_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wiki_forms/1
  # DELETE /wiki_forms/1.json
  def destroy
    @wiki_form = WikiForm.find(params[:id])
    @wiki_form.destroy

    respond_to do |format|
      format.html { redirect_to wiki_forms_url }
      format.json { head :no_content }
    end
  end
end
