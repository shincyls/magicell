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
  {username: "nelson", email: "nelson@magicell.com", password: "qwerasdf", role: 3},
  {username: "manager1", email: "mgr1@magicell.com", password: "qwerasdf", role: 3},
  {username: "manager2", email: "mgr2@magicell.com", password: "qwerasdf", role: 3},
  {username: "manager3", email: "mgr3@magicell.com", password: "qwerasdf", role: 3}
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
  {first_name: "Ng", last_name: "Nelson", user_id: 6, company_id: 1, department_id: 3, project_id: 4},
  {first_name: "Manager1", last_name: "Test1", user_id: 8, company_id: 1, department_id: 3, project_id: 2, position: "Manager"},
  {first_name: "Manager2", last_name: "Test2", user_id: 9, company_id: 1, department_id: 3, project_id: 3, position: "Manager"},
  {first_name: "Manager3", last_name: "Test3", user_id: 10, company_id: 1, department_id: 3, project_id: 4, position: "Manager"}
])

Leavetype.create!([
  {name: "Annual Leave"},
  {name: "Sick Leave"},
  {name: "Marriage Leave"},
  {name: "Maternity Leave"},
  {name: "Compassionate Leave"},
  {name: "Unpaid Leave"},
  {name: "Others"}
])

Leaveap.create!([
  {employee_id: 1, apv_mgr_1_id: 8, apv_mgr_2_id: 9, leavetype_id: 1, reason: "Balik Kampung", contact_person: "Shin", contact_number: "012-3456789", from_date: "2019-08-22", to_date: "2019-08-23"},
  {employee_id: 1, apv_mgr_1_id: 8, apv_mgr_2_id: 9, leavetype_id: 2, reason: "Balik Rumah", contact_person: "Shin", contact_number: "012-3456789", from_date: "2019-08-22", to_date: "2019-08-24"},
  {employee_id: 1, apv_mgr_1_id: 8, apv_mgr_2_id: 9, leavetype_id: 3, reason: "Balik Hometown", contact_person: "Shin", contact_number: "012-3456789", from_date: "2019-08-22", to_date: "2019-08-25"}
])

TimesheetCategory.create!([
  {name: "DTA"},
  {name: "OSS"}
])


Holiday.create!([
  {date: "2019-1-1", remarks: "New Year's Day"},
  {date: "2019-1-21", remarks: "Thaipusam"},
  {date: "2019-2-5", remarks: "Chinese New Year"},
  {date: "2019-2-6", remarks: "Chinese New Year Holiday"},
  {date: "2019-5-1", remarks: "Labour Day"},
  {date: "2019-5-19", remarks: "Wesak Day"},
  {date: "2019-5-20", remarks: "Wesak Day Holiday"},
  {date: "2019-5-22", remarks: "Nuzul Al-Quran"},
  {date: "2019-6-5", remarks: "Hari Raya Aidilfitri"},
  {date: "2019-6-6", remarks: "Hari Raya Aidilfitri Holiday"},
  {date: "2019-7-30", remarks: "Installation of YDP Agong"},
  {date: "2019-8-11", remarks: "Hari Raya Haji"},
  {date: "2019-8-12", remarks: "Hari Raya Haji Holiday"},
  {date: "2019-8-31", remarks: "Merdeka Day"},
  {date: "2019-9-1", remarks: "Awal Muharram"},
  {date: "2019-9-2", remarks: "Awal Muharram Holiday"},
  {date: "2019-9-9", remarks: "Agong's Birthday"},
  {date: "2019-9-16", remarks: "Malaysia Day"},
  {date: "2019-10-27", remarks: "Deepavali"},
  {date: "2019-10-28", remarks: "Deepavali Holiday"},
  {date: "2019-11-9", remarks: "Prophet Muhammad's Birthday"},
  {date: "2019-12-11", remarks: "Sultan of Selangor's Birthday"},
  {date: "2019-12-25", remarks: "Christmas Day"},
  {date: "2020-1-1", remarks: "New Year's Day"},
  {date: "2020-1-25", remarks: "Chinese New Year"},
  {date: "2020-1-26", remarks: "Chinese New Year Holiday"},
  {date: "2020-1-27", remarks: "Chinese New Year Holiday"},
  {date: "2020-2-8", remarks: "Thaipusam"},
  {date: "2020-5-1", remarks: "Labour Day"},
  {date: "2020-5-7", remarks: "Wesak Day"},
  {date: "2020-5-10", remarks: "Nuzul Al-Quran"},
  {date: "2020-5-11", remarks: "Nuzul Al-Quran Holiday"},
  {date: "2020-5-24", remarks: "Hari Raya Aidilfitri"},
  {date: "2020-5-25", remarks: "Hari Raya Aidilfitri Holiday"},
  {date: "2020-5-26", remarks: "Hari Raya Aidilfitri Holiday"},
  {date: "2020-6-6", remarks: "Agong's Birthday"},
  {date: "2020-7-31", remarks: "Hari Raya Haji"},
  {date: "2020-8-20", remarks: "Awal Muharram"},
  {date: "2020-8-31", remarks: "Merdeka Day"},
  {date: "2020-9-16", remarks: "Malaysia Day"},
  {date: "2020-10-29", remarks: "Prophet Muhammad's Birthday"},
  {date: "2020-11-14", remarks: "Deepavali"},
  {date: "2020-12-11", remarks: "Sultan of Selangor's Birthday"},
  {date: "2020-12-25", remarks: "Christmas Day"},
  {date: "2021-1-1", remarks: "New Year's Day"},
  {date: "2021-1-28", remarks: "Thaipusam"},
  {date: "2021-2-12", remarks: "Chinese New Year"},
  {date: "2021-2-13", remarks: "Chinese New Year Holiday"},
  {date: "2021-4-29", remarks: "Nuzul Al-Quran"},
  {date: "2021-5-1", remarks: "Labour Day"},
  {date: "2021-5-13", remarks: "Hari Raya Aidilfitri"},
  {date: "2021-5-14", remarks: "Hari Raya Aidilfitri Holiday"},
  {date: "2021-5-26", remarks: "Wesak Day"},
  {date: "2021-6-5", remarks: "Agong's Birthday"},
  {date: "2021-7-20", remarks: "Hari Raya Haji"},
  {date: "2021-8-10", remarks: "Awal Muharram"},
  {date: "2021-8-31", remarks: "Merdeka Day"},
  {date: "2021-9-16", remarks: "Malaysia Day"},
  {date: "2021-10-19", remarks: "Prophet Muhammad's Birthday"},
  {date: "2021-11-4", remarks: "Deepavali"},
  {date: "2021-12-11", remarks: "Sultan of Selangor's Birthday"},
  {date: "2021-12-25", remarks: "Christmas Day"}
])




  
