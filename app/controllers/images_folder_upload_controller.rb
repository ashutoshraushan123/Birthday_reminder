class ImagesFolderUploadController < ApplicationController
	def upload
		   @error = Person.upload(params[:dump][:file])
	end
end
