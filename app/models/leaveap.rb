class Leaveap < ApplicationRecord  

    belongs_to :employee
    belongs_to :leavetype

    belongs_to :employee, class_name: 'Employee', foreign_key: 'employee_id'
    belongs_to :apv_mgr_1, class_name: 'Employee', foreign_key: 'apv_mgr_1_id'
    belongs_to :apv_mgr_2, class_name: 'Employee', foreign_key: 'apv_mgr_2_id'
    # belongs_to :apv_mgr_3, class_name: 'Employee', foreign_key: 'apv_mgr_3_id'
    
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