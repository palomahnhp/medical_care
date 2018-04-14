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

ActiveRecord::Schema.define(version: 20180414155637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyses", force: :cascade do |t|
    t.date "extracted_at"
    t.bigint "patient_id"
    t.bigint "professional_id"
    t.bigint "appointment_id"
    t.bigint "medical_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["appointment_id"], name: "index_analyses_on_appointment_id"
    t.index ["medical_center_id"], name: "index_analyses_on_medical_center_id"
    t.index ["patient_id"], name: "index_analyses_on_patient_id"
    t.index ["professional_id"], name: "index_analyses_on_professional_id"
  end

  create_table "analysis_results", force: :cascade do |t|
    t.bigint "analytical_item_id"
    t.bigint "analysis_id"
    t.float "amount"
    t.string "unit"
    t.string "level"
    t.string "grade"
    t.text "interpretation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_id"], name: "index_analysis_results_on_analysis_id"
    t.index ["analytical_item_id"], name: "index_analysis_results_on_analytical_item_id"
  end

  create_table "analytical_groups", force: :cascade do |t|
    t.string "name"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "analytical_items", force: :cascade do |t|
    t.string "name"
    t.bigint "analytical_group_id"
    t.string "unit"
    t.string "max_range"
    t.string "min_range"
    t.boolean "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytical_group_id"], name: "index_analytical_items_on_analytical_group_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "professional_id"
    t.text "reason"
    t.datetime "appointment_time"
    t.bigint "medical_center_id"
    t.string "location"
    t.string "update_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_center_id"], name: "index_appointments_on_medical_center_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["professional_id"], name: "index_appointments_on_professional_id"
  end

  create_table "histories", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "appointment_id"
    t.text "note"
    t.integer "order"
    t.string "update_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_histories_on_appointment_id"
    t.index ["patient_id"], name: "index_histories_on_patient_id"
  end

  create_table "medical_centers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "kind"
    t.string "main_phone"
    t.string "appointment_phone"
    t.string "email"
    t.string "web"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medical_tests", force: :cascade do |t|
    t.bigint "appointment_id"
    t.string "name"
    t.time "date"
    t.text "instructions"
    t.text "results"
    t.index ["appointment_id"], name: "index_medical_tests_on_appointment_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.string "active_ingredient"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prospect_file_name"
    t.string "prospect_content_type"
    t.integer "prospect_file_size"
    t.datetime "prospect_updated_at"
  end

  create_table "patients", force: :cascade do |t|
    t.string "nickname"
    t.string "firstname"
    t.string "surname"
    t.date "born_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prescriptions", force: :cascade do |t|
    t.bigint "appointments_id"
    t.bigint "medication_id"
    t.string "posology"
    t.date "init_at"
    t.date "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointments_id"], name: "index_prescriptions_on_appointments_id"
    t.index ["medication_id"], name: "index_prescriptions_on_medication_id"
    t.index ["posology"], name: "index_prescriptions_on_posology"
  end

  create_table "professionals", force: :cascade do |t|
    t.string "firstname"
    t.string "surname"
    t.bigint "speciality_id"
    t.bigint "medical_center_id"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_center_id"], name: "index_professionals_on_medical_center_id"
    t.index ["speciality_id"], name: "index_professionals_on_speciality_id"
  end

  create_table "specialities", force: :cascade do |t|
    t.string "denomination"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "analyses", "appointments"
  add_foreign_key "analyses", "medical_centers"
  add_foreign_key "analyses", "patients"
  add_foreign_key "analyses", "professionals"
  add_foreign_key "analysis_results", "analyses"
  add_foreign_key "analysis_results", "analytical_items"
  add_foreign_key "analytical_items", "analytical_groups"
  add_foreign_key "appointments", "medical_centers"
  add_foreign_key "appointments", "patients"
  add_foreign_key "appointments", "professionals"
  add_foreign_key "histories", "appointments"
  add_foreign_key "histories", "patients"
  add_foreign_key "prescriptions", "appointments", column: "appointments_id"
  add_foreign_key "prescriptions", "medications"
end
