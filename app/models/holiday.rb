class Holiday < ApplicationRecord

    def self.list
        @collect = self.where(activate: true).collect {|l| l.date.to_s }
        return @collect
    end

    def self.to_js
        @collect = self.where(activate: true).collect {|l| [ l.show, "disabled disabled-date", l.date ] }
        return @collect
    end

end


    