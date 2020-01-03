class Project < ApplicationRecord

    require 'csv'

    belongs_to :company, optional: true
    belongs_to :department, optional: true
    belongs_to :project_client
    belongs_to :manager, class_name: 'Employee', foreign_key: 'manager_id'
    belongs_to :manager_alt, class_name: 'Employee', foreign_key: 'manager_alt_id', optional: true
    has_many :employees
    has_many :timesheet_tasks
    has_many :expense_lists

    enum project_status: ["Active","Archieved","Others"]

    validates :name, presence: {message: "must present."}, uniqueness: {message: "already exists!"}

    def total_claims
    end

    def total_timesheets
    end


    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            params = row.to_hash
            # Data Adjustment to Fit into Database
            params['manager_id'] = params['manager_id'].to_i
            params['manager_alt_id'] = params['manager_alt_id'].to_i
            # Importing Data Here
            if Project.exists?(name: params['name'])
                params.reject{|_, v| v.blank?}
                @project = Project.find_by(name: params['name'])
                @project.update(params)
            end
        end
    end

end