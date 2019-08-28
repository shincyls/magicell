class Timesheet < ApplicationRecord

    attr_accessor :multi_date_from
    attr_accessor :multi_date_to
    attr_accessor :include_weekend

    belongs_to :employee
    belongs_to :project
    belongs_to :timesheet_category
    belongs_to :timesheet_approval, optional: true
    # belongs_to :apv_mgr_3, class_name: 'Employee', foreign_key: 'apv_mgr_3_id'

    scope :year_month, ->(year,month){
        date = Date.new(year,month)
        where(date: date..date.next_month-1.day)
    }

    def year_month
        @collection = self.map{|e| e.date.strftime("%b-%Y")}.uniq
        return @collection
    end

    def self.list
        @collect = self.all.collect {|l| l.date.strftime("%Y-%b")}.uniq
        return @collect
    end

end