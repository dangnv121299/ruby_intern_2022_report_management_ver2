# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_23_015910) do

  create_table "departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "status", default: 0
    t.text "plan_today"
    t.text "reality"
    t.text "reason"
    t.text "plan_next_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "user_department_id"
    t.bigint "department_id"
    t.index ["department_id"], name: "index_reports_on_department_id"
    t.index ["user_department_id"], name: "index_reports_on_user_department_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "user_departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "day_start"
    t.integer "role", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "department_id"
    t.index ["department_id"], name: "index_user_departments_on_department_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.integer "role", default: 0
    t.string "address"
    t.string "password_digest"
    t.boolean "activated", default: false
    t.string "reset_digest"
    t.datetime "reset_send_at"
    t.date "day_start"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_department_id"], name: "index_users_on_user_department_id"
  end

  add_foreign_key "reports", "departments"
  add_foreign_key "reports", "user_departments"
  add_foreign_key "reports", "users"
  add_foreign_key "user_departments", "departments"
  add_foreign_key "users", "user_departments"
end
