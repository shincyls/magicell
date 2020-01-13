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
    t.bigint "users_id", default: 0
    t.string "announcement"
    t.string "remarks"
    t.date "start_date"
    t.date "end_date"
    t.boolean "show", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_announcements_on_users_id"
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
    t.bigint "company_id"
    t.string "name"
    t.string "description"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_departments_on_company_id"
  end

  create_table "employee_positions", force: :cascade do |t|
    t.string "position"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "department_id", default: 1
    t.bigint "project_id", default: 1
    t.bigint "company_id", default: 1
    t.bigint "employee_position_id", default: 1
    t.string "full_name"
    t.string "gender"
    t.string "personal_email"
    t.string "company_email"
    t.string "employee_code"
    t.string "job_title"
    t.string "phone_number"
    t.string "phone_number_emergency"
    t.string "address"
    t.string "address_2"
    t.string "nationality"
    t.string "race"
    t.string "identity_no"
    t.string "bank_name"
    t.string "bank_account"
    t.string "socso_account"
    t.boolean "include_socso", default: false
    t.string "epf_account"
    t.boolean "include_epf", default: false
    t.string "lhdn_account"
    t.string "medical_account"
    t.string "insurance_account"
    t.string "marital_status"
    t.string "spouse_name"
    t.integer "children_count"
    t.date "birthday"
    t.date "ep_expire"
    t.date "joined_since"
    t.date "joined_last"
    t.float "base_salary", default: 0.0
    t.float "fix_allowance", default: 0.0
    t.float "annual_leave_entitled", default: 12.0
    t.float "annual_leave_taken", default: 0.0
    t.float "medical_leave_entitled", default: 12.0
    t.float "medical_leave_taken", default: 0.0
    t.date "contract_start"
    t.date "contract_end"
    t.integer "category", default: 0
    t.integer "employment_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["employee_position_id"], name: "index_employees_on_employee_position_id"
    t.index ["project_id"], name: "index_employees_on_project_id"
  end

  create_table "expense_lists", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "project_id"
    t.bigint "status_expense_id", default: 1
    t.date "date"
    t.float "fuel_claim", default: 0.0
    t.float "toll_claim", default: 0.0
    t.float "parking_claim", default: 0.0
    t.float "allowance_claim", default: 0.0
    t.float "medical_claim", default: 0.0
    t.float "others_claim", default: 0.0
    t.integer "odometer_reading", default: 0
    t.integer "holiday", default: 0
    t.string "attachment_link"
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_expense_lists_on_employee_id"
    t.index ["project_id"], name: "index_expense_lists_on_project_id"
    t.index ["status_expense_id"], name: "index_expense_lists_on_status_expense_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.date "date"
    t.string "remarks"
    t.boolean "activate", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaveaps", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "leavetype_id", default: 1
    t.bigint "status_leave_id", default: 1
    t.string "reason"
    t.string "contact_person"
    t.string "contact_number"
    t.date "from_date"
    t.string "from_ampm", default: "AM"
    t.date "to_date"
    t.string "to_ampm", default: "PM"
    t.float "days", default: 0.0
    t.boolean "submitted", default: false
    t.bigint "apv_mgr_1_id"
    t.bigint "apv_mgr_2_id"
    t.bigint "apv_mgr_3_id"
    t.boolean "apv_1", default: false
    t.boolean "apv_2", default: false
    t.boolean "apv_3", default: false
    t.string "attachment_link"
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apv_mgr_1_id"], name: "index_leaveaps_on_apv_mgr_1_id"
    t.index ["apv_mgr_2_id"], name: "index_leaveaps_on_apv_mgr_2_id"
    t.index ["apv_mgr_3_id"], name: "index_leaveaps_on_apv_mgr_3_id"
    t.index ["employee_id"], name: "index_leaveaps_on_employee_id"
    t.index ["leavetype_id"], name: "index_leaveaps_on_leavetype_id"
    t.index ["status_leave_id"], name: "index_leaveaps_on_status_leave_id"
  end

  create_table "leavetypes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "days", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "project_clients", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_regions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "vendor"
    t.string "operator"
    t.date "start_date"
    t.date "end_date"
    t.bigint "company_id"
    t.bigint "department_id"
    t.bigint "manager_id"
    t.bigint "manager_alt_id"
    t.bigint "project_client_id", default: 1
    t.boolean "site?", default: false
    t.boolean "vehicle?", default: false
    t.integer "project_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["department_id"], name: "index_projects_on_department_id"
    t.index ["manager_alt_id"], name: "index_projects_on_manager_alt_id"
    t.index ["manager_id"], name: "index_projects_on_manager_id"
    t.index ["project_client_id"], name: "index_projects_on_project_client_id"
  end

  create_table "status_expenses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "css", default: "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_leaves", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "css", default: "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_timesheets", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "css", default: "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheet_categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheet_tasks", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "project_id"
    t.bigint "timesheet_category_id", default: 1
    t.bigint "status_timesheet_id", default: 1
    t.bigint "vehicle_owner_id"
    t.bigint "project_region_id"
    t.date "date"
    t.string "activity"
    t.string "site_name", limit: 6
    t.string "vehicle_number", limit: 8
    t.integer "working_hours", default: 8
    t.float "working_wages", default: 0.0
    t.string "attachment_link"
    t.integer "holiday", default: 0
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_timesheet_tasks_on_employee_id"
    t.index ["project_id"], name: "index_timesheet_tasks_on_project_id"
    t.index ["project_region_id"], name: "index_timesheet_tasks_on_project_region_id"
    t.index ["status_timesheet_id"], name: "index_timesheet_tasks_on_status_timesheet_id"
    t.index ["timesheet_category_id"], name: "index_timesheet_tasks_on_timesheet_category_id"
    t.index ["vehicle_owner_id"], name: "index_timesheet_tasks_on_vehicle_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "remember_digest"
    t.bigint "webrole_id", default: 2
    t.bigint "employee_id"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["employee_id"], name: "index_users_on_employee_id"
    t.index ["webrole_id"], name: "index_users_on_webrole_id"
  end

  create_table "vehicle_owners", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webapp_contents", force: :cascade do |t|
    t.string "name"
    t.string "param"
    t.float "value"
    t.boolean "logic"
    t.datetime "datetime"
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
