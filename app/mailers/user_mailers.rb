class UserMailers < ApplicationMailer
default from: "batman"
	
	def deliver_contact(recipient,url,sent_at = Time.now)

      
      @recipients = recipient
      @from = 'railsda@gmail.com'
      
@url=url
      

		mail(:to => @recipients,:subject => "sahitya password recovery", :body =>"click the link to reset password "+@url)

	  # @body["title"] = 'This is title'
  	#   @body["email"] = 'sender@yourdomain.com'
   # 	  @body["message"] = message
   #    @headers = {}
   end
end
