class SendMail < ActiveRecord::Base
	#def self.ew_send_mail(username,email)
     # mail = EwMail.ew_new_mail(username,email)  # => a Mail::Message object
      
      # mail = EwMail.ew_new_mail("ranjith@nfnlabs.in,mukesh@nfnlabs.in",name,country,email,phone,service,budget)  # => a Mail::Message object
     # mail.delivery_method.settings.merge!({:user_name=>"support@nfnlabs.in", :password=>"Remember.001"})
     # mail.deliver  
      # SendMail.ew_send_mail_spreadsheet(username,email)
    #end


    # def self.ew_send_mail_spreadsheet(username,email)
   	# 	# require 'httpclient'
    # 	require 'json'
    #   # hash = Hash.new
    # 	# hash["entry_1941238993"] = username
    # 	# hash["entry_443438918"] = email
    # 	 # ProjectBase.send_request("post","https://docs.google.com/a/nfnlabs.in/forms/d/1eWC64_6nQI93pR1nYTmT8hf2_jLyzqf0-g_ECLWRUtM/formResponse",hash)

    # end


end
