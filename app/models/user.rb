class User < ApplicationRecord
    #Validate The Format and Presence of Required Information
    validates :email, uniqueness: {message: "Account already exists!"}, format: {with: /.+@.+\..+/, message: ": Please enter a valid email address."}, presence: {message: ": Please enter your email address."}
	validates :username, uniqueness: {message: ": Username already exists!"}, presence: {message: ": Please enter your username."}
    # validates :first_name, presence: {message: ": Please enter your first name."}
    # validates :last_name, presence: {message: ": Please enter your last name."}
    
    has_one :employee
    
    #Bcrypt with Secured Password
    has_secure_password

    #CarrierWave for uploader
    mount_uploader :avatar, AvatarUploader

    enum role: ["super", "admin", "hr", "user"]

    def fullname
       self.first_name + " " + self.last_name
    end

end
