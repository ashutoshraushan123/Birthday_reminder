class UserMailer < ActionMailer::Base


 default from: "indusnet.testacc@gmail.com"

   def welcome_email(user)
  	@user = user
  	@url = "../users/sign_in"
  	mail(:to => user.email, :subject => "Warm Wishes To You")
   end

  def notification_email(user,p)
  	@user = user
  	@notice=p
    logger.info"======================#{@notice.inspect}"
  	mail(:to => user.email, :subject => "Birthday Notifications")
   end

end
