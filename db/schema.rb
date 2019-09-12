# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_31_000000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.string "title"
    t.string "remarks"
    t.datetime "from"
    t.datetime "until"
    t.boolean "display", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "contact_1"
    t.string "contact_2"
    t.string "description"
    t.string "email_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "info_1"
    t.string "info_2"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_departments_on_company_id"
  end

  create_table "employee_contracts", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "project_id"
    t.date "start_from"
    t.date "end_at"
    t.float "base_salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_contracts_on_employee_id"
    t.index ["project_id"], name: "index_employee_contracts_on_project_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "personal_email"
    t.string "company_email"
    t.string "employee_id"
    t.string "position"
    t.string "title"
    t.string "phone_number"
    t.string "phone_number_2"
    t.string "address"
    t.string "address_2"
    t.string "nationality"
    t.string "race"
    t.string "identity_passport_no"
    t.string "marital_status"
    t.string "spouse_name"
    t.string "bank_name"
    t.string "bank_account"
    t.integer "children_count"
    t.date "birthday"
    t.date "joined_since"
    t.date "joined_last"
    t.float "base_salary", default: 0.0
    t.float "annual_leave_entitled", default: 0.0
    t.float "annual_leave_taken", default: 0.0
    t.float "medical_leave_entitled", default: 0.0
    t.float "medical_leave_taken", default: 0.0
    t.date "contract_start"
    t.date "contract_end"
    t.integer "category", default: 0
    t.integer "employement_status", default: 0
    t.boolean "approve_expense", default: false
    t.boolean "approve_leave", default: false
    t.boolean "approve_timesheet", default: false
    t.bigint "department_id"
    t.bigint "project_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["project_id"], name: "index_employees_on_project_id"
  end

  create_table "expense_approvals", force: :cascade do |t|
    t.bigint "expense_id"
    t.bigint "employee_id"
    t.bigint "manager_id"
    t.boolean "approval", default: false
    t.boolean "reject", default: false
    t.string "reject_reason"
    t.string "manager_remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_expense_approvals_on_employee_id"
    t.index ["expense_id"], name: "index_expense_approvals_on_expense_id"
    t.index ["manager_id"], name: "index_expense_approvals_on_manager_id"
  end

  create_table "expense_lists", force: :cascade do |t|
    t.bigint "expense_id"
    t.bigint "employee_id"
    t.date "date"
    t.float "fuel_claim"
    t.float "toll_claim"
    t.float "parking_claim"
    t.float "allowance_claim"
    t.float "medical_claim"
    t.float "others_claim"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_expense_lists_on_employee_id"
    t.index ["expense_id"], name: "index_expense_lists_on_expense_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "session"
    t.integer "year"
    t.integer "month"
    t.boolean "submitted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_expenses_on_employee_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.date "date"
    t.string "remarks"
    t.boolean "holiday", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaveaps", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "leavetype_id", default: 1
    t.string "reason"
    t.string "contact_person"
    t.string "contact_number"
    t.date "from_date"
    t.string "from_ampm", default: "AM"
    t.date "to_date"
    t.string "to_ampm", default: "PM"
    t.boolean "app_confirm", default: false
    t.bigint "apv_mgr_1_id"
    t.bigint "apv_mgr_2_id"
    t.bigint "apv_mgr_3_id"
    t.boolean "apv_1", default: false
    t.boolean "apv_2", default: false
    t.boolean "apv_3", default: false
    t.string "apv_reject_1"
    t.string "apv_reject_2"
    t.string "apv_reject_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apv_mgr_1_id"], name: "index_leaveaps_on_apv_mgr_1_id"
    t.index ["apv_mgr_2_id"], name: "index_leaveaps_on_apv_mgr_2_id"
    t.index ["apv_mgr_3_id"], name: "index_leaveaps_on_apv_mgr_3_id"
    t.index ["employee_id"], name: "index_leaveaps_on_employee_id"
    t.index ["leavetype_id"], name: "index_leaveaps_on_leavetype_id"
  end

  create_table "leavetypes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "days", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payrolls", force: :cascade do |t|
    t.bigint "employee_id"
    t.integer "month"
    t.float "month_salary"
    t.float "expenses_claim", default: 0.0
    t.float "others_claim", default: 0.0
    t.float "leave_deduction", default: 0.0
    t.float "socso", default: 0.0
    t.float "epf_employer", default: 0.0
    t.float "epf_employee", default: 0.0
    t.float "payslip_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_payrolls_on_employee_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "vendor"
    t.string "operator"
    t.bigint "company_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["department_id"], name: "index_projects_on_department_id"
  end

  create_table "timesheet_approvals", force: :cascade do |t|
    t.bigint "timesheet_id"
    t.bigint "employee_id"
    t.bigint "manager_id"
    t.boolean "approval", default: false
    t.boolean "reject", default: false
    t.string "reject_reason"
    t.string "manager_remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_timesheet_approvals_on_employee_id"
    t.index ["manager_id"], name: "index_timesheet_approvals_on_manager_id"
    t.index ["timesheet_id"], name: "index_timesheet_approvals_on_timesheet_id"
  end

  create_table "timesheet_categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheet_tasks", force: :cascade do |t|
    t.bigint "timesheet_id"
    t.bigint "employee_id"
    t.string "activity"
    t.string "site_name"
    t.string "location"
    t.date "date"
    t.integer "time_in", default: 9
    t.integer "time_out", default: 18
    t.integer "time_break", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_timesheet_tasks_on_employee_id"
    t.index ["timesheet_id"], name: "index_timesheet_tasks_on_timesheet_id"
  end

  create_table "timesheets", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "timesheet_category_id"
    t.bigint "project_id"
    t.string "session"
    t.integer "year"
    t.integer "month"
    t.boolean "submitted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_timesheets_on_employee_id"
    t.index ["project_id"], name: "index_timesheets_on_project_id"
    t.index ["timesheet_category_id"], name: "index_timesheets_on_timesheet_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "remember_digest"
    t.bigint "webrole_id", default: 2
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["employee_id"], name: "index_users_on_employee_id"
    t.index ["webrole_id"], name: "index_users_on_webrole_id"
  end

  create_table "webapp_contents", force: :cascade do |t|
    t.string "name"
    t.string "param"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webroles", force: :cascade do |t|
    t.string "role"
    t.string "description"
    t.boolean "rails_admin", default: false
    t.boolean "vw_director", default: false
    t.boolean "vw_emp", default: false
    t.boolean "vw_hr", default: false
    t.boolean "vw_finance", default: false
    t.boolean "vw_pro_mgr", default: false
    t.boolean "vw_dpt_mgr", default: false
    t.boolean "vw_it", default: false
    t.boolean "vw_market", default: false
    t.boolean "vw_sale", default: false
    t.boolean "vw_support", default: false
    t.boolean "vw_intern", default: false
    t.boolean "vw_subcon", default: false
    t.boolean "wr_director", default: false
    t.boolean "wr_emp", default: false
    t.boolean "wr_hr", default: false
    t.boolean "wr_finance", default: false
    t.boolean "wr_pro_mgr", default: false
    t.boolean "wr_dpt_mgr", default: false
    t.boolean "wr_it", default: false
    t.boolean "wr_market", default: false
    t.boolean "wr_sale", default: false
    t.boolean "wr_support", default: false
    t.boolean "wr_intern", default: false
    t.boolean "wr_subcon", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
