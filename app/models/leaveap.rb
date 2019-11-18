class Leaveap < ApplicationRecord

    validates :from_date, presence: {message: " must exist."}
    validates :to_date, presence: {message: " must exist."}
    validates :leavetype_id, presence: {message: " must exist."}
    validates :reason, presence: {message: " must exist."}
    validates :contact_person, presence: {message: " must exist."}
    validates :contact_number, presence: {message: " must exist."}
    validates :attachment_link, presence: {message: " must exist."}
    validate :duplicate_manager

    belongs_to :employee
    belongs_to :leavetype
    belongs_to :status_leave
   
    belongs_to :apv_mgr_1, class_name: 'Employee', foreign_key: 'apv_mgr_1_id'
    belongs_to :apv_mgr_2, class_name: 'Employee', foreign_key: 'apv_mgr_2_id', optional: true

    # Calculate Total Days taken for this leave

    def duplicate_manager
        if (self.apv_mgr_1_id == self.apv_mgr_2_id)
          errors.add(:apv_mgr_1_id, "Approval Manager cannot be same.")
        end
    end

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

    def approve_sum
        final = self.apv_1
        (final = final & self.apv_2) if self.apv_mgr_2_id
        (final = final & self.apv_3) if self.apv_mgr_3_id
        return final
    end

    def url
        self.attachment_link.gsub("https://","").gsub("http://","")
    end

end