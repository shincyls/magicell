class Holiday < ApplicationRecord

    def self.list
        @collect = self.where(holiday: true).collect {|l| l.date.to_s }
        return @collect.to_json
    end

    def self.to_js
        @collect = self.where(holiday: true).collect {|l| [ l.holiday, "disabled disabled-date", l.date ] }
        return @collect
    end

end


    