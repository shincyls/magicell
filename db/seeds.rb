# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'smarter_csv'
require 'csv'
require 'open-uri'

# options = {:col_sep => ';',
#   row_sep: "\r",
#   chunk_size: 100,
#   convert_values_to_numeric: false,
#   remove_empty_hashes: false
# }
  
# SmarterCSV.process('app/assets/files/magicell.csv', options) do |chunk|
#   chunk.each do |data_hash|
#     Employee.create!(data_hash)
#   end
# end

# PageContent.create!([
#   {name: "running_number", value: 1}
# ])

User.create!([
  {username: "super1", email: "super1@magicell.com", password: "$uper!23", role: 0},
  {username: "admin1", email: "admin1@magicell.com", password: "@dmin!23", role: 1},
  {username: "xiaolong", email: "xiaolong@magicell.com", password: "qwerasdf", role: 2},
  {username: "johari", email: "johari@magicell.com", password: "qwerasdf", role: 3},
  {username: "simon", email: "simon@magicell.com", password: "qwerasdf", role: 3},
  {username: "ahmad", email: "ahmad@magicell.com", password: "qwerasdf", role: 3},
  {username: "nelson", email: "nelson@magicell.com", password: "qwerasdf", role: 3}
])

Company.create!([
  {name: "Magicell", description: "This is Magicell Company"}
])

Department.create!([
  {name: "Director", description: "Oversee the company", company_id: 1},
  {name: "Humans Resources", description: "Humans Resource Management", company_id: 1},
  {name: "Project Team", description: "Project Management", company_id: 1}
])

Project.create!([
  {name: "None", department_id: 1, company_id: 1},
  {name: "Ericsson Celcom", department_id: 3, company_id: 1},
  {name: "Nokia UMobile", department_id: 3, company_id: 1},
  {name: "Ericsson Digi", department_id: 3, company_id: 1}
])

Employee.create!([
  {first_name: "Shin", last_name: "Chee Yap", user_id: 2, company_id: 1, department_id: 1, project_id: 1},
  {first_name: "Lee", last_name: "Xiao Long", user_id: 3, company_id: 1, department_id: 1, project_id: 1},
  {first_name: "Ahmad", last_name: "Johari", user_id: 4, company_id: 1, department_id: 2, project_id: 1},
  {first_name: "Lim", last_name: "Simon", user_id: 5, company_id: 1, department_id: 3, project_id: 2},
  {first_name: "Suffian", last_name: "Ahmad", user_id: 5, company_id: 1, department_id: 3, project_id: 3},
  {first_name: "Ng", last_name: "Nelson", user_id: 6, company_id: 1, department_id: 3, project_id: 4}
])

Leaveap.create!([
  {employee_id: 1, reason: "Balik Kampung", contact_person: "Shin", contact_number: "012-3456789"},
  {employee_id: 1, reason: "Balik Rumah", contact_person: "Shin", contact_number: "012-3456789"},
  {employee_id: 1, reason: "Balik Hometown", contact_person: "Shin", contact_number: "012-3456789"}
])

Timesheet.create!([
  {employee_id: 1, task: "Frequency Planning"},
  {employee_id: 1, task: "RF Optimization"}
])






  
