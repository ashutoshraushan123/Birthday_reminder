class PeopleController < ApplicationController
  # GET /people
  # GET /people.json
  
   before_filter :authenticate_user!
   # load_and_authorize_resource

  def index
    #render :file => "public/401.html", :status => :unauthorized, :layout => false

    @people = Person.order(:id)

     @dept = Department.all

    respond_to do |format|
      format.html # index.html.erb
      
      format.csv { send_data @people.to_csv }
      format.xls { send_data @people.to_xls }
      
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new
    @templates = Template.all
    #logger.info "....................#{@templates.inspect}.........."
    @dept = Department.all
    @team = Team.all
    @u=Array.new
      @u << "All"
     @dept.each do |d|
      
        @u.push(d.dept)

     end

  logger.info "....................#{@u.inspect}.........."
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    @templates = Template.all
    @dept = Department.all
    @team = Team.all
    @u=Array.new
     
      @u << "All"
     @dept.each do |d|
      
        @u.push(d.dept)

      end

     # unauthorized! if cannot? :edit, @person
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    @person.template_id =params[:template]

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Employee was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])
    @person.template_id =params[:template]

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end

   
  end

 def  find_birthday

       @people = Person.find(:all, :conditions => ["DAY(date) = ? AND MONTH(date) = ?", Date.today.day, Date.today.month])
       @dept=@people.group_by{|t| t.dept}
       @dept_keys=@dept.keys
        @dept_keys.each do |dept|
           if (dept=="All")
              @bday_people = Person.find(:all, :conditions => ["dept=? AND DAY(date) = ? AND MONTH(date) = ?",dept,Date.today.day, Date.today.month])
              @notification = Person.find(:all, :conditions =>['DAY(date) <> ? OR MONTH(date) <> ?',Date.today.day, Date.today.month])
                 @notification.each do|n| 
                   UserMailer.notification_email(n,@bday_people).deliver
                 end
           elsif (dept=="")

           else
              @team = @people.group_by{|t| t.team_name}
              @team_keys=@team.keys
      
              @team_keys.each do |l|
                  if(l=="All")
                     @bday_people =Person.find(:all, :conditions => ["team_name=? AND DAY(date) = ? AND MONTH(date) = ?",l,Date.today.day, Date.today.month])
                     @notification = Person.find(:all, :conditions =>['dept=? AND DAY(date) <> ? OR MONTH(date) <> ?',dept,Date.today.day, Date.today.month])
                     @dept_all = Person.find(:all, :conditions =>['dept=? AND DAY(date) <> ? OR MONTH(date) <> ?',"All",Date.today.day, Date.today.month])
                        @notification.each do|n| 
                           UserMailer.notification_email(n,@bday_people).deliver
                        end
                        @dept_all.each do|n| 
                           UserMailer.notification_email(n,@bday_people).deliver
                        end

                  elsif(l=="")
                  else
                      @bday_people =Person.find(:all, :conditions => ["team_name=? AND DAY(date) = ? AND MONTH(date) = ?",l,Date.today.day, Date.today.month])
                      @notification = Person.find(:all, :conditions =>['team_name=? AND DAY(date) <> ? OR MONTH(date) <> ?',l,Date.today.day, Date.today.month])
                        @dept_all= Person.find(:all, :conditions =>['dept=? AND DAY(date) <> ? OR MONTH(date) <> ?',"All",Date.today.day, Date.today.month])
                       @notification.each do|n| 
                          UserMailer.notification_email(n,@bday_people).deliver
                       end
                       logger.info"*******************************#{@dept_all.inspect}*"
                       @dept_all.each do|n| 
                          UserMailer.notification_email(n,@bday_people).deliver
                       end
                  end
               end


            end


        end
        p=@people.count

        @people.each do |e|
           UserMailer.welcome_email(e).deliver
        end
       
        redirect_to "/people" 
     
  end

  def calendar


    newdate = params[:newdate].split("-")
     #logger.info "....................#{newdate.inspect}.........."
     @people = Person.where("DATE_FORMAT(date,'%d') = ? AND DATE_FORMAT(date,'%b') = ? ", newdate[0], newdate[1])

     @people.each do|p|
         logger.info "....................#{p.name}.........."
     end
    
      target = @people.last.id.to_i
       logger.info "....................#{target.inspect}.........."


       respond_to do |format|
          #format.js {render json: target.to_json}
         format.js {render partial: "display", :locals => {:tar => target}}
       end    
  end

   def team_count
     @team =Team.where("depart=?",params[:dept])
       respond_to do |format|
         format.json{render json: @team.collect{|t| [t.id, t.team_name]}}
       end
      
   end  


end
