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

ActiveRecord::Schema.define(version: 20180308215710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.string "author"
    t.string "author_category"
    t.string "action"
    t.string "status"
    t.string "action_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "costing_comments", force: :cascade do |t|
    t.string "description"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_costing_comments_on_service_id"
  end

  create_table "custody_orders", force: :cascade do |t|
    t.string "subject"
    t.bigint "employee_id"
    t.bigint "supervisor_id"
    t.bigint "service_id"
    t.integer "custody_progress"
    t.text "supervisor_observation"
    t.boolean "supervised_validation", default: true
    t.integer "revision_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_custody_orders_on_employee_id"
    t.index ["service_id"], name: "index_custody_orders_on_service_id"
    t.index ["supervisor_id"], name: "index_custody_orders_on_supervisor_id"
  end

  create_table "features", force: :cascade do |t|
    t.float "minimun_value", default: 0.0
    t.float "maximum_value", default: 0.0
    t.string "description"
    t.bigint "samples_category_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["samples_category_method_id"], name: "index_features_on_samples_category_method_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.text "description"
    t.date "date_of_entry"
    t.integer "amount"
    t.string "code"
    t.string "name"
    t.string "brand"
    t.string "product_model"
    t.integer "status"
    t.bigint "laboratory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_inventories_on_laboratory_id"
  end

  create_table "laboratories", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "phone"
    t.string "description"
    t.string "area"
    t.string "location"
    t.string "web"
    t.date "creation_date"
    t.boolean "active", default: true
    t.bigint "sections_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sections_id"], name: "index_laboratories_on_sections_id"
  end

  create_table "menu_actions", force: :cascade do |t|
    t.bigint "menu_id"
    t.bigint "role_id"
    t.boolean "create"
    t.boolean "edit"
    t.boolean "view"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_actions_on_menu_id"
    t.index ["role_id"], name: "index_menu_actions_on_role_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "navigation_name"
    t.string "controller_name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preliminary_orders", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "quantity"
    t.float "unit_cost"
    t.bigint "service_id"
    t.bigint "sample_method_id"
    t.bigint "sample_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sample_category_id"], name: "index_preliminary_orders_on_sample_category_id"
    t.index ["sample_method_id"], name: "index_preliminary_orders_on_sample_method_id"
    t.index ["service_id"], name: "index_preliminary_orders_on_service_id"
  end

  create_table "processed_samples", force: :cascade do |t|
    t.text "description"
    t.text "classified_values"
    t.float "discount"
    t.float "subtotal_cost"
    t.string "pucp_code"
    t.string "client_code"
    t.bigint "preliminary_order_id"
    t.bigint "custody_order_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custody_order_id"], name: "index_processed_samples_on_custody_order_id"
    t.index ["preliminary_order_id"], name: "index_processed_samples_on_preliminary_order_id"
    t.index ["service_id"], name: "index_processed_samples_on_service_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active", default: true
    t.bigint "laboratory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_roles_on_laboratory_id"
  end

  create_table "sample_categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active", default: true
    t.bigint "laboratory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_sample_categories_on_laboratory_id"
  end

  create_table "sample_methods", force: :cascade do |t|
    t.float "unit_cost"
    t.string "name"
    t.string "description"
    t.boolean "active", default: true
    t.integer "accreditation", default: 0
    t.bigint "laboratory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_sample_methods_on_laboratory_id"
  end

  create_table "samples_category_methods", force: :cascade do |t|
    t.bigint "sample_category_id"
    t.bigint "sample_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sample_category_id"], name: "index_samples_category_methods_on_sample_category_id"
    t.index ["sample_method_id"], name: "index_samples_category_methods_on_sample_method_id"
  end

  create_table "services", force: :cascade do |t|
    t.date "pick_up_date"
    t.float "total"
    t.string "subject"
    t.integer "progress"
    t.boolean "active", default: true
    t.boolean "attended", default: true
    t.boolean "funded_validation", default: true
    t.bigint "client_id"
    t.bigint "employee_id"
    t.bigint "laboratory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "client_quotation_observation"
    t.boolean "engagement", default: false
    t.index ["client_id"], name: "index_services_on_client_id"
    t.index ["employee_id"], name: "index_services_on_employee_id"
    t.index ["laboratory_id"], name: "index_services_on_laboratory_id"
  end

  create_table "supplies", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "description"
    t.float "quantity"
    t.string "measure_unit"
    t.bigint "laboratory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_supplies_on_laboratory_id"
  end

  create_table "system_parameters", force: :cascade do |t|
    t.integer "feature"
    t.text "description"
    t.bigint "laboratory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_system_parameters_on_laboratory_id"
  end

  create_table "users", force: :cascade do |t|
    t.date "date_of_birth"
    t.string "ruc"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address"
    t.string "contact_person"
    t.integer "gender"
    t.integer "category"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "laboratory_id"
    t.bigint "role_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["laboratory_id"], name: "index_users_on_laboratory_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
