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

WebappContent.create!([
  {name: "Default Password", param: "Magicell!23"}
])

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

Employee.create!([
  {full_name: "Manager Account", first_name: "Test", last_name: "Manager Account", employee_id: "M001", company_id: 1, department_id: 4, project_id: 1, personal_email: "owner@gmail.com", company_email: "owner@magicell.com.my", identity_passport_no: "810101-01-6475", phone_number: "012-3456789", approve_expense: true, approve_leave: true, approve_timesheet: true},
  {full_name: "Lee Xiao Long", first_name: "Lee", last_name: "Xiao Long", employee_id: "M002",company_id: 1, department_id: 1, project_id: 1, personal_email: "user1@gmail.com", company_email: "user1@magicell.com.my", identity_passport_no: "810101-02-6475", phone_number: "012-3456788"},
  {full_name: "Ahmad Johari", first_name: "Ahmad", last_name: "Johari", employee_id: "M003",company_id: 1, department_id: 2, project_id: 1, personal_email: "user2@gmail.com", company_email: "user2@magicell.com.my", identity_passport_no: "810101-03-6475", phone_number: "012-3456787"},
  {full_name: "Simon Kong", first_name: "Simon", last_name: "Kong", employee_id: "M004",company_id: 1, department_id: 3, project_id: 2, personal_email: "user3@gmail.com", company_email: "user3@magicell.com.my", identity_passport_no: "810101-04-6475", phone_number: "012-3456786"},
  {full_name: "Syaiful Bukhari", first_name: "Syaiful", last_name: "Bukhari", employee_id: "M005",company_id: 1, department_id: 5, project_id: 3, personal_email: "user4@gmail.com", company_email: "user4@magicell.com.my", identity_passport_no: "810101-05-6475", phone_number: "012-3456785"},
  {full_name: "Daniel Nelson", first_name: "Daniel", last_name: "Nelson", employee_id: "M006",company_id: 1, department_id: 5, project_id: 4, personal_email: "user5@gmail.com", company_email: "user5@magicell.com.my", identity_passport_no: "810101-06-6475", phone_number: "012-3456784"},
  {full_name: "Tan Manager", first_name: "Tan", last_name: "Manager", employee_id: "M007",company_id: 1, department_id: 5, project_id: 2, personal_email: "user6@gmail.com", company_email: "user6@magicell.com.my", identity_passport_no: "810101-07-6475", phone_number: "012-3456783", approve_expense: true, approve_leave: true, approve_timesheet: true},
  {full_name: "Wong Manager", first_name: "Wong", last_name: "Manager", employee_id: "M008",company_id: 1, department_id: 5, project_id: 3, personal_email: "user7@gmail.com", company_email: "user7@magicell.com.my", identity_passport_no: "810101-08-6475", phone_number: "012-3456782", approve_expense: true, approve_leave: true, approve_timesheet: true},
  {full_name: "Kong Manager", first_name: "Kong", last_name: "Manager", employee_id: "M009",company_id: 1, department_id: 5, project_id: 4, personal_email: "user8@gmail.com", company_email: "user8@magicell.com.my", identity_passport_no: "810101-09-6475", phone_number: "012-3456781", approve_expense: true, approve_leave: true, approve_timesheet: true},
  {full_name: "Lee Manager", first_name: "Lee", last_name: "Manager", employee_id: "M010",company_id: 1, department_id: 5, project_id: 4, personal_email: "user9@gmail.com", company_email: "user9@magicell.com.my", identity_passport_no: "810101-10-6475", phone_number: "012-3456780", approve_expense: true, approve_leave: true, approve_timesheet: true}
])

User.create!([
  {username: "owner", password: "M@g!c3lL", webrole_id: 3, employee_id: 1},
  {username: "admin1", password: "@dmin!23", webrole_id: 3, employee_id: 2},
  {username: "xiaolong", password: "qwerasdf", webrole_id: 1, employee_id: 3},
  {username: "johari", password: "qwerasdf", webrole_id: 6, employee_id: 4},
  {username: "simon", password: "qwerasdf", webrole_id: 7, employee_id: 5},
  {username: "ahmad", password: "qwerasdf", webrole_id: 8, employee_id: 6},
  {username: "nelson", password: "qwerasdf", webrole_id: 9, employee_id: 7},
  {username: "manager1", password: "qwerasdf", webrole_id: 5, employee_id: 8},
  {username: "manager2", password: "qwerasdf", webrole_id: 5, employee_id: 9},
  {username: "manager3", password: "qwerasdf", webrole_id: 5, employee_id: 10}
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




  
