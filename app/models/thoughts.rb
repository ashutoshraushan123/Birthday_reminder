class Thoughts < ActiveRecord::Base
  attr_accessible :detail

  def self.import(file) 
   logger.info"=================#{file.inspect}"                                # For importing
    spreadsheet = open_spreadsheet(file)
    logger.info"=================#{spreadsheet.inspect}"
    @err = []
    @alt = []
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]

    @t = Thoughts.find_by_id(row["id"]) ||Thoughts.new
    @t.detail = row["Name"]
    @t.save
    end
    #  else
    #     @err << {:name => row["Name"].to_s,:error => @person.errors.messages}
    #  end
    
    # end
    # @err.each do |t|

    #   @alt.push(t[:name])

    
    # end
    return @err

  end


  def self.open_spreadsheet(file)                         # Importing method open_spreadsheet
	  case File.extname(file.original_filename)
	  when ".csv" then Csv.new(file.path, nil, :ignore)
	  when ".xls" then Excel.new(file.path, nil, :ignore)
	  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
  end

end
