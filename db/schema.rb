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

ActiveRecord::Schema.define(version: 2022_09_20_064013) do

  create_table "daily_reports", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "status", default: 0
    t.text "plan_today"
    t.text "reality"
    t.text "reason"
    t.text "plan_next_day"
    t.bigint "users_id", null: false
    t.bigint "user_departments_id", null: false
    t.bigint "departments_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["departments_id"], name: "index_daily_reports_on_departments_id"
    t.index ["user_departments_id"], name: "index_daily_reports_on_user_departments_id"
    t.index ["users_id"], name: "index_daily_reports_on_users_id"
  end

  create_table "departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "day_start"
    t.integer "role", default: 1
    t.bigint "departments_id", null: false
    t.bigint "users_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["departments_id"], name: "index_user_departments_on_departments_id"
    t.index ["users_id"], name: "index_user_departments_on_users_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.integer "role", default: 1
    t.string "address"
    t.string "password_digest"
    t.boolean "activated", default: false
    t.string "reset_digest"
    t.datetime "reset_send_at"
    t.datetime "day_start"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "daily_reports", "departments", column: "departments_id"
  add_foreign_key "daily_reports", "user_departments", column: "user_departments_id"
  add_foreign_key "daily_reports", "users", column: "users_id"
  add_foreign_key "user_departments", "departments", column: "departments_id"
  add_foreign_key "user_departments", "users", column: "users_id"
end
