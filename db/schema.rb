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

  create_table "eaforms", force: :cascade do |t|
    t.bigint "employee_id"
    t.integer "year"
    t.float "base_salary", default: 0.0
    t.float "expenses_claim", default: 0.0
    t.float "others_claim", default: 0.0
    t.float "leave_deduction", default: 0.0
    t.float "socso", default: 0.0
    t.float "epf_employer", default: 0.0
    t.float "epf_employee", default: 0.0
    t.float "operator"
    t.string "eaform_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_eaforms_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "employee_id"
    t.string "title"
    t.string "phone_number"
    t.string "phone_number_2"
    t.string "identity_number"
    t.date "birthday"
    t.float "base_salary", default: 0.0
    t.float "annual_leave_entitled", default: 12.0
    t.float "annual_leave_taken", default: 0.0
    t.float "medical_leave_entitled", default: 12.0
    t.float "medical_leave_taken", default: 0.0
    t.integer "position", default: 2
    t.integer "category", default: 0
    t.integer "employement_status", default: 0
    t.bigint "user_id"
    t.bigint "department_id"
    t.bigint "company_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["project_id"], name: "index_employees_on_project_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "leaveaps", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "leave_type"
    t.string "reason"
    t.string "contact_person"
    t.string "contact_number"
    t.date "from_date"
    t.integer "from_ampm", default: 0
    t.date "to_date"
    t.integer "to_ampm", default: 0
    t.string "total_days"
    t.boolean "confirm", default: false
    t.boolean "approved_1", default: false
    t.string "reject_reason_1"
    t.boolean "approved_2", default: false
    t.string "reject_reason_2"
    t.boolean "approved_3", default: false
    t.string "reject_reason_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_leaveaps_on_employee_id"
  end

  create_table "page_contents", force: :cascade do |t|
    t.string "name"
    t.float "value"
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
    t.float "operator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_payrolls_on_employee_id"
  end

  create_table "payslips", force: :cascade do |t|
    t.bigint "employee_id"
    t.integer "month"
    t.float "base_salary", default: 0.0
    t.float "expenses_claim", default: 0.0
    t.float "others_claim", default: 0.0
    t.float "leave_deduction", default: 0.0
    t.float "socso", default: 0.0
    t.float "epf_employer", default: 0.0
    t.float "epf_employee", default: 0.0
    t.float "operator"
    t.string "payslip_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_payslips_on_employee_id"
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

  create_table "registers", force: :cascade do |t|
    t.string "full_name"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "phone_number_2"
    t.string "identity_number"
    t.float "purchase", default: 0.0
    t.integer "drawing_chance", default: 0
    t.string "ticket_number", limit: 3
    t.integer "status", default: 0
    t.integer "category", default: 0
    t.boolean "attendance", default: false
    t.string "holder"
    t.string "info_1"
    t.string "info_2"
    t.string "info_3"
    t.string "info_4"
    t.string "info_5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheets", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "task"
    t.string "contact"
    t.date "date"
    t.string "slot_1"
    t.string "slot_2"
    t.string "slot_3"
    t.string "slot_4"
    t.string "slot_5"
    t.string "slot_6"
    t.string "slot_7"
    t.string "slot_8"
    t.string "slot_9"
    t.string "slot_10"
    t.boolean "confirm", default: false
    t.boolean "approved_1", default: false
    t.string "reject_1"
    t.boolean "approved_2", default: false
    t.string "reject_2"
    t.boolean "approved_3", default: false
    t.string "reject_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_timesheets_on_employee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.integer "role", default: 1
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["employee_id"], name: "index_users_on_employee_id"
  end

  create_table "variables", force: :cascade do |t|
    t.float "socso_perc"
    t.float "epf_employer_perc"
    t.float "epf_employee_perc"
    t.float "eis_perc"
    t.float "pcb_perc"
  end

end
