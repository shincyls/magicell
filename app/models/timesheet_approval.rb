class TimesheetApproval < ApplicationRecord

    has_many :timesheets
    belongs_to :employee
    belongs_to :apv_mgr_1, class_name: 'User', foreign_key: 'apv_mgr_1_id'
    belongs_to :apv_mgr_2, class_name: 'User', foreign_key: 'apv_mgr_2_id', optional: true

end