class UsersController < ApplicationController  

   def login

    res1 = ""
    if (validate_login_user(params))
      res1 = User.login_user(params)
      
      #HttpPermission.cors_post_permission(headers)
        if res1==false
           HttpPermission.cors_post_permission(headers)
          render :json =>{:message => "something went wrong" }, :status =>201
       else
          HttpPermission.cors_post_permission(headers)
          render :json => res1, :status =>200
  
    end
    end  
    
  end

   # ************************ Signup New User validate_create_new_user **************************************
  def validate_login_user(params)

    create_params = ['email','password']

    begin
      create_params.each do |r|
        if !params["#{r}"].present?
          return false
        end
       
      end
      return true
    rescue
      return false
    end
  end
   require 'securerandom'
def daga
random_string = SecureRandom.hex
      render :json => random_string

end
  def create
    random_string = SecureRandom.hex
    @user = User.new(:username => params["username"], :password => params["password"], :email => params["email"], :token => random_string, :role => "user")
    if @user.save
    HttpPermission.cors_post_permission(headers)  
    render :json => {:token => @user.token}, :status =>200
    else
          HttpPermission.cors_post_permission(headers)
          render :json => {:message => "something went wrong" }, :status =>201
    end
   end
def sendmail
if User.exists?(:email => params['email'])
login = params['email']
 user = User.find_by(email: login)
 
 code = SecureRandom.hex
 user.update(pwtoken: code)
 url = "#{request.protocol}#{request.host_with_port}"+"/sample/#{code}"
 mail = UserMailers.deliver_contact(login,url).deliver # => a Mail::Message object
HttpPermission.cors_post_permission(headers)
 render :json => {:message => "message sent"}, :status => 200
else
HttpPermission.cors_post_permission(headers) 
render :json => {:message => "invalid mail id"}, :status => 201
end
end
  def mailreturnlink
    @pwd = params['pwtoken']
    ppp =  params['crm']
    #render :json => ppp


  user = User.find_by(pwtoken: @pwd)
if User.update_password1(user,ppp)
          
         json = {"success" => 1, "message" => "success" }
      else
          json = {"success" => 0, "message" => "update get fail" }
      end
    #render :json => pwd
  end
  
end
