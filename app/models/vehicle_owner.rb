class VehicleOwner < ApplicationRecord

    has_many :timesheet_tasks
    
end