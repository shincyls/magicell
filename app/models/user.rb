class User < ApplicationRecord
    #Validate The Format and Presence of Required Information
    # validates :email, uniqueness: {message: "Account already exists!"}, format: {with: /.+@.+\..+/, message: ": Please enter a valid email address."}, presence: {message: ": Please enter your email address."}
	validates :username, uniqueness: {message: "already exists!"}, presence: {message: "must presense."}

    belongs_to :employee, optional: true
    belongs_to :webrole, optional: true

    #Bcrypt with Secured Password
    has_secure_password

    #CarrierWave for uploader
    mount_uploader :avatar, AvatarUploader

    def fullname
       self.first_name + " " + self.last_name
    end
    
    def send_password_reset
        self.password_reset_token = generate_token
        self.password_reset_sent_at = Time.now
        self.save
        UserMailer.forgot_password(self.id).deliver # This sends an e-mail with a link for the user to reset the password
    end
     
    # This generates a random password reset token for the user
    def generate_token
        return SecureRandom.urlsafe_base64
    end

    protected

    def generate_token
        self.password_reset_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless User.exists?(password_reset_token: random_token)
        end
    end

end
