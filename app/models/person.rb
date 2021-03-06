class Person < ActiveRecord::Base

 #cts_as_authentic
  attr_accessible :date, :email, :name, :avatar ,:template_id,:dept,:team_name

   
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_one :template
   #validates_attachment_content_type :avatar, :content_type => 'image/jpeg'
  #validates_attachment :avatar,:content_type => {:content_type => ['image/jpeg', 'image/png','image/gif','image/jpg','image/bmp']}  
  validates :email, :uniqueness => true 
  validates_presence_of :email 
  validates_format_of :email, :with => /^[a-z0-9_\+-]+(\.[a-z0-9_\+-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.([a-z]{2,4})$/
 #validates_format_of :avatar,:with => /(\.bmp|\.png|\.jpg|\.jpeg|\.gif)$/

   belongs_to :department
   belongs_to :team

def self.to_csv(options = {})                               # For Exporting (CSV)
    CSV.generate(options) do |csv|
      csv << column_names
      logger.info".............#{csv.inspect}............"
    person = Person.find_by_id(row["id"]) ||Person.new
      all.each do |person|
        csv << person.attributes.values_at(*column_names)
       end
    end
end

def as_xls(options = {}){                                 # For Exporting (Excel)
 
  "Name" => name,
  "Date" => date,
  "E-Mail" => email,
  "Dept" => dept,
  "Team" => team_name,} 

end

def self.import(file)                                  # For importing
  spreadsheet = open_spreadsheet(file)
  @err = []
  @alt = []
  header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    # logger.info"..................#{row.inspect}............." 
    @person = Person.find_by_id(row["id"]) ||Person.new
    # logger.info"++++++++++++++++++++++#{row["Name"].to_s.inspect}"
    #  logger.info"++++++++++++++++++++++#{row["Date"].inspect}"
    #   logger.info"++++++++++++++++++++++#{row["E-Mail"].inspect}"
    #    logger.info"++++++++++++++++++++++#{row["Dept"].inspect}"
    #     logger.info"++++++++++++++++++++++#{row["Team"].inspect}"
    @person.name = row["Name"].to_s
    @person.date = row["Date"]
    @person.email = row["E-Mail"]
    @person.dept = row["Dept"]
    @person.team_name = row["Team"]
    @person.template_id ="1"
     if @person.save

     else
        @err << {:name => row["Name"].to_s,:error => @person.errors.messages}
     end
    
    end
    @err.each do |t|

      @alt.push(t[:name])

    
    end
      logger.info "xxxxxxxxxxxxxxxxxxxxxx#{@alt.inspect}"
  return @alt
   
end

def self.open_spreadsheet(file)                         # Importing method open_spreadsheet
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end


def self.upload(file)
 zipfile_name="#{file.original_filename}"
 Zip::ZipFile::open(zipfile_name) do |zip|
   logger.info "================#{file.inspect}============"
 zip.each do |entry|
   logger.info "**************************#{entry.inspect}"
   next if entry.name =~ /__MACOSX/ or entry.name =~ /\.DS_Store/ or !entry.file?
   logger.info "#{entryinspect}"
   FileUtils::mkdir_p(File.dirname(entry.name)) # might want to check if it already exists    
   @data = File.new("#{Rails.root.to_s}/tmp/#{entry.name}")
 end
end


end


def self.open_zipfolder(file)
      # File.extname(file.original_filename)


end

 # named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }

 #  ROLES = %w[admin user]

 #  def roles=(roles)
 #    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
 #  end

 #  def roles
 #    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
 #  end

 #  def role?(role)
 #    roles.include? role.to_s
 #  end

end
