class ExpenseList < ApplicationRecord

    attr_accessor :multi_date_from
    attr_accessor :multi_date_to

    belongs_to :employee
    belongs_to :project
    belongs_to :status_expense

    validates :date, presence: {message: "must present."}
    validates :employee_id, presence: {message: "must present."}
    validates :project_id, presence: {message: "must present."}
    validates :attachment_link, presence: {message: " must exist."}
    
    def total_claim
        @sum = self.fuel_claim + self.toll_claim + self.parking_claim + self.allowance_claim + self.medical_claim + self.others_claim
        return @sum
    end

    def url
        self.attachment_link.gsub('https://','').gsub('http://','')
    end

    def holiday?
        self.date.saturday? or self.date.sunday? or Holiday.list.include?(self.date.strftime("%F"))
    end

end