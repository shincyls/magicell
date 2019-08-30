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

# WebappContent.create!([
#   {name: "running_number", value: 1}
# ])

Webrole.create!([
  {role: "Default"},
  {role: "Employee", vw_emp: true, wr_emp: true},
  {role: "Webmaster", vw_emp: true, wr_emp: true, vw_pro_mgr: true, wr_pro_mgr: true, vw_dpt_mgr: true, wr_dpt_mgr: true, vw_finance: true, wr_finance: true, vw_it: true, wr_it: true, vw_hr: true, wr_hr: true},
  {role: "Director", vw_emp: true, wr_emp: true, vw_pro_mgr: true, wr_pro_mgr: true, vw_dpt_mgr: true, wr_dpt_mgr: true, vw_finance: true, wr_finance: true, vw_it: true, wr_it: true, vw_hr: true, wr_hr: true},
  {role: "Project Manager", vw_emp: true, wr_emp: true, vw_pro_mgr: true, wr_pro_mgr: true},
  {role: "Department Manager", vw_emp: true, wr_emp: true, vw_dpt_mgr: true, wr_dpt_mgr: true},
  {role: "Finance", vw_emp: true, wr_emp: true, vw_finance: true, wr_finance: true},
  {role: "IT", vw_emp: true, wr_emp: true, vw_it: true, wr_it: true},
  {role: "HR", vw_emp: true, wr_emp: true, vw_hr: true, wr_hr: true}
])

Employee.create!([
  {first_name: "Shin", last_name: "Chee Yap", company_id: 1, department_id: 1, project_id: 1},
  {first_name: "Lee", last_name: "Xiao Long", company_id: 1, department_id: 1, project_id: 1},
  {first_name: "Ahmad", last_name: "Johari", company_id: 1, department_id: 2, project_id: 1},
  {first_name: "Simon", last_name: "Kong", company_id: 1, department_id: 3, project_id: 2},
  {first_name: "Syaiful", last_name: "Bukhari", company_id: 1, department_id: 3, project_id: 3},
  {first_name: "Daniel", last_name: "Nelson", company_id: 1, department_id: 3, project_id: 4},
  {first_name: "Tan", last_name: "Manager", company_id: 1, department_id: 3, project_id: 2},
  {first_name: "Wong", last_name: "Manager", company_id: 1, department_id: 3, project_id: 3},
  {first_name: "Kong", last_name: "Manager", company_id: 1, department_id: 3, project_id: 4},
  {first_name: "Lee", last_name: "Manager", company_id: 1, department_id: 3, project_id: 4},
])

User.create!([
  {username: "super1", email: "super1@magicell.com", password: "$uper!23", webrole_id: 3, employee_id: 1},
  {username: "admin1", email: "admin1@magicell.com", password: "@dmin!23", webrole_id: 3, employee_id: 2},
  {username: "xiaolong", email: "xiaolong@magicell.com", password: "qwerasdf", webrole_id: 1, employee_id: 3},
  {username: "johari", email: "johari@magicell.com", password: "qwerasdf", webrole_id: 6, employee_id: 4},
  {username: "simon", email: "simon@magicell.com", password: "qwerasdf", webrole_id: 7, employee_id: 5},
  {username: "ahmad", email: "ahmad@magicell.com", password: "qwerasdf", webrole_id: 8, employee_id: 6},
  {username: "nelson", email: "nelson@magicell.com", password: "qwerasdf", webrole_id: 9, employee_id: 7},
  {username: "manager1", email: "mgr1@magicell.com", password: "qwerasdf", webrole_id: 5, employee_id: 8},
  {username: "manager2", email: "mgr2@magicell.com", password: "qwerasdf", webrole_id: 5, employee_id: 9},
  {username: "manager3", email: "mgr3@magicell.com", password: "qwerasdf", webrole_id: 5, employee_id: 10}
])

Company.create!([
  {name: "Magicell", description: "Magicell Sdn Bhd, Malaysia"}
])

Department.create!([
  {name: "Director", description: "Owner of Company", company_id: 1},
  {name: "Humans Resources", description: "Humans Resource Management", company_id: 1},
  {name: "Finance", description: "Finance Management", company_id: 1},
  {name: "IT", description: "IT Management", company_id: 1},
  {name: "Project Team", description: "Project Management", company_id: 1}
])

Project.create!([
  {name: "None", department_id: 1, company_id: 1},
  {name: "Ericsson Celcom", department_id: 3, company_id: 1},
  {name: "Nokia UMobile", department_id: 3, company_id: 1},
  {name: "Ericsson Digi", department_id: 3, company_id: 1}
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
  {date: "2019-01-01", remarks: "New Year's Day"},
  {date: "2019-01-21", remarks: "Thaipusam"},
  {date: "2019-02-05", remarks: "Chinese New Year"},
  {date: "2019-02-06", remarks: "Chinese New Year Holiday"},
  {date: "2019-05-01", remarks: "Labour Day"},
  {date: "2019-05-19", remarks: "Wesak Day"},
  {date: "2019-05-20", remarks: "Wesak Day Holiday"},
  {date: "2019-05-22", remarks: "Nuzul Al-Quran"},
  {date: "2019-06-05", remarks: "Hari Raya Aidilfitri"},
  {date: "2019-06-06", remarks: "Hari Raya Aidilfitri Holiday"},
  {date: "2019-07-30", remarks: "Installation of YDP Agong"},
  {date: "2019-08-11", remarks: "Hari Raya Haji"},
  {date: "2019-08-12", remarks: "Hari Raya Haji Holiday"},
  {date: "2019-08-31", remarks: "Merdeka Day"},
  {date: "2019-09-01", remarks: "Awal Muharram"},
  {date: "2019-09-02", remarks: "Awal Muharram Holiday"},
  {date: "2019-09-09", remarks: "Agong's Birthday"},
  {date: "2019-09-16", remarks: "Malaysia Day"},
  {date: "2019-10-27", remarks: "Deepavali"},
  {date: "2019-10-28", remarks: "Deepavali Holiday"},
  {date: "2019-11-09", remarks: "Prophet Muhammad's Birthday"},
  {date: "2019-12-11", remarks: "Sultan of Selangor's Birthday"},
  {date: "2019-12-25", remarks: "Christmas Day"},
  {date: "2020-01-01", remarks: "New Year's Day"},
  {date: "2020-01-25", remarks: "Chinese New Year"},
  {date: "2020-01-26", remarks: "Chinese New Year Holiday"},
  {date: "2020-01-27", remarks: "Chinese New Year Holiday"},
  {date: "2020-02-08", remarks: "Thaipusam"},
  {date: "2020-05-01", remarks: "Labour Day"},
  {date: "2020-05-07", remarks: "Wesak Day"},
  {date: "2020-05-10", remarks: "Nuzul Al-Quran"},
  {date: "2020-05-11", remarks: "Nuzul Al-Quran Holiday"},
  {date: "2020-05-24", remarks: "Hari Raya Aidilfitri"},
  {date: "2020-05-25", remarks: "Hari Raya Aidilfitri Holiday"},
  {date: "2020-05-26", remarks: "Hari Raya Aidilfitri Holiday"},
  {date: "2020-06-06", remarks: "Agong's Birthday"},
  {date: "2020-07-31", remarks: "Hari Raya Haji"},
  {date: "2020-08-20", remarks: "Awal Muharram"},
  {date: "2020-08-31", remarks: "Merdeka Day"},
  {date: "2020-09-16", remarks: "Malaysia Day"},
  {date: "2020-10-29", remarks: "Prophet Muhammad's Birthday"},
  {date: "2020-11-14", remarks: "Deepavali"},
  {date: "2020-12-11", remarks: "Sultan of Selangor's Birthday"},
  {date: "2020-12-25", remarks: "Christmas Day"},
  {date: "2021-01-01", remarks: "New Year's Day"},
  {date: "2021-01-28", remarks: "Thaipusam"},
  {date: "2021-02-12", remarks: "Chinese New Year"},
  {date: "2021-02-13", remarks: "Chinese New Year Holiday"},
  {date: "2021-04-29", remarks: "Nuzul Al-Quran"},
  {date: "2021-05-01", remarks: "Labour Day"},
  {date: "2021-05-13", remarks: "Hari Raya Aidilfitri"},
  {date: "2021-05-14", remarks: "Hari Raya Aidilfitri Holiday"},
  {date: "2021-05-26", remarks: "Wesak Day"},
  {date: "2021-06-05", remarks: "Agong's Birthday"},
  {date: "2021-07-20", remarks: "Hari Raya Haji"},
  {date: "2021-08-10", remarks: "Awal Muharram"},
  {date: "2021-08-31", remarks: "Merdeka Day"},
  {date: "2021-09-16", remarks: "Malaysia Day"},
  {date: "2021-10-19", remarks: "Prophet Muhammad's Birthday"},
  {date: "2021-11-04", remarks: "Deepavali"},
  {date: "2021-12-11", remarks: "Sultan of Selangor's Birthday"},
  {date: "2021-12-25", remarks: "Christmas Day"}
])




  
