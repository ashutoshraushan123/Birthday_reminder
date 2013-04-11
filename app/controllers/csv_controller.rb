class CsvController < ApplicationController

  def import
	#Person.import(params[:dump][:file])
     @error = []
      @error = Person.import(params[:dump][:file])
		logger.info "xxxx++++++++++++xxxx#{@error.inspect}"
		if @error.blank?
			redirect_to people_path, notice: "Employees imported."
		else
    
         redirect_to people_path, notice: "Employees imported.",:flash => { :error => "Employees( Email : invalid/blank) are not saved : #{@error.join("  , ")}" }
       end
  end

end
