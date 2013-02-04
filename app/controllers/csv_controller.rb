class CsvController < ApplicationController

  def import
	#Person.import(params[:dump][:file])
     @error = []
      @error = Person.import(params[:dump][:file])
		logger.info "xxxxxxxxxxxxxxxxxxxxxx#{@error.inspect}"
    
     redirect_to people_path, notice: "Employees imported.",:flash => { :error => "Employees( Email : invalid/blank) are not saved : #{@error.join("  , ")}" }
  end

end
