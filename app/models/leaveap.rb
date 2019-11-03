class Leaveap < ApplicationRecord

    # validates :full_name, presence: {message: " must presense."}
    # validates :last_name, presence: {message: " must presense."}
    # validates :drawing_chance, presence: {message: " must be selected."}
    # validates :email, uniqueness: {message: " must be unique."}, format: {with: /.+@.+\..+/, message: " format must be valid."}, presence: {message: " must presence."}

    belongs_to :employee
    belongs_to :leavetype
    has_many :leaveap_approvals

    belongs_to :apv_mgr_1, class_name: 'User', foreign_key: 'apv_mgr_1_id'
    belongs_to :apv_mgr_2, class_name: 'User', foreign_key: 'apv_mgr_2_id', optional: true

    # Calculate Total Days taken for this leave
    def total_days
        unless (self.to_date.nil?) or (self.from_date.nil?)
            @total_days = 0
            @date = self.to_date
            while @date >= self.from_date
                @total_days += 1 unless @date.saturday? or @date.sunday?
                @date = @date - 1.day
            end
            @total_days -= 0.5 if self.from_ampm == "PM"
            @total_days -= 0.5 if self.to_ampm == "AM"
        else
            @total_days = 0
        end
        return @total_days
    end

end