class User < ApplicationRecord
    #Validate The Format and Presence of Required Information
    # validates :email, uniqueness: {message: "Account already exists!"}, format: {with: /.+@.+\..+/, message: ": Please enter a valid email address."}, presence: {message: ": Please enter your email address."}
	validates :username, uniqueness: {message: "already exists!"}, presence: {message: "must presense."}

    belongs_to :employee, optional: true
    belongs_to :webrole, optional: true
    has_many :primary_tsas, class_name: 'TimesheetApproval', foreign_key: 'apv_mgr_1_id'
    has_many :secondary_tsas, class_name: 'TimesheetApproval', foreign_key: 'apv_mgr_2_id'
    has_many :primary_las, class_name: 'Leaveap', foreign_key: 'apv_mgr_1_id'
    has_many :secondary_las, class_name: 'Leaveap', foreign_key: 'apv_mgr_2_id'
    
    #Bcrypt with Secured Password
    has_secure_password

    #CarrierWave for uploader
    mount_uploader :avatar, AvatarUploader

    def fullname
       self.first_name + " " + self.last_name
    end

end
