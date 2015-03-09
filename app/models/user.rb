class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
after_save :clear_password
  # attr_accessible :username, :email, :password, :password_confirmation
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  before_save :encrypt_password
after_save :clear_password
def encrypt(password)
      self.class.encrypt(password, salt)
    end
    def self.encrypt(password, salt)
      Digest::SHA1.hexdigest("--#{salt}--#{password}--")
    end
    def self.authenticate(login, password)
      #u = find_by_login(login) # need to get the salt
      u = User.where(:email => login).first 
      u && u.authenticated?(password) ? u : nil
    end
    
    def authenticated?(password)
      encrypted_password == encrypt(password)
    end  
def encrypt_password
  if password.present?
    # self.salt = BCrypt::Engine.generate_salt
    # self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
      self.encrypted_password = encrypt(password)
  end
end
def clear_password
  self.password = nil
end
def self.update_password1(user,ppp)
    if user.update_attributes({:encrypted_password => User.encrypt(ppp, user.salt)})
    # successsfully update
         
    return true
    else
    # failed update
    return false
    end
  end
def self.login_user(params)

    user = User.authenticate(params['email'],params['password'])
    if user.present?
    return user
  else return false
  end

  end

end

