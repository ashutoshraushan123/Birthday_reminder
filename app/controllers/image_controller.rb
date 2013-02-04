 class ImageController < ApplicationController


  def new
    
  	@people = Person.where("avatar_file_name is ?",nil)

  end


 def create

     @people = Person.where("avatar_file_name is ?",nil)
 	
     p=@people.count

     u=Array.new
     
     @people.each do |e|
     	
        u.push(e.id)
     end
   

     h=Hash.new
 	   h=params

 	   u.each do |x|
          
            @person = Person.find(x)
            @person.update_attribute(:avatar,h["#{x}"])
 	   end

    redirect_to "/people",notice: "Image imported."

   # redirect_to() 
  end

 

 def index
  

   @people = Person.order(:id)

    respond_to do |format|
      format.html # index.html.erb 
    end
   

 end

end