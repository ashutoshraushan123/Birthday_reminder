class ThoughtsController < ApplicationController

  def index

    #newdate = params[:newdate].split("-")
    #@people = Person.where("DATE_FORMAT(date,'%d') = ? AND DATE_FORMAT(date,'%b') = ? AND dept=? ", newdate[0], newdate[1],dept)
     @thought = Thoughts.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @thought }
    end
  end
	def new
      @thought = Thoughts.new

       respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @thought }
       end
   end

   def import
       @error = []
       @error = Thoughts.import(params[:dump][:detail])
         logger.info"++++++++++#{@error.inspect}+++++++++++++++++"
       redirect_to thoughts_path, notice: "Thoughts imported."
   end

end
