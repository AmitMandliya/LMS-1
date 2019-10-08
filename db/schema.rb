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

ActiveRecord::Schema.define(version: 2019_10_08_032053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.index ["users_id"], name: "index_admins_on_users_id"
  end

  create_table "book_request", force: :cascade do |t|
    t.date "date"
    t.boolean "is_special"
    t.boolean "is_approved"
    t.integer "books_id"
    t.integer "librarians_id"
    t.integer "students_id"
    t.index ["books_id"], name: "index_book_request_on_books_id"
    t.index ["librarians_id"], name: "index_book_request_on_librarians_id"
    t.index ["students_id"], name: "index_book_request_on_students_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.string "language"
    t.date "published"
    t.string "edition"
    t.string "image"
    t.string "subject"
    t.text "summary"
    t.boolean "special_collection"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "book_count"
    t.boolean "is_issued"
    t.integer "number_hold_req"
    t.bigint "libraries_id"
    t.index ["libraries_id"], name: "index_books_on_libraries_id"
  end

  create_table "librarians", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "library"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.bigint "libraries_id"
    t.boolean "approved"
    t.index ["libraries_id"], name: "index_librarians_on_libraries_id"
    t.index ["users_id"], name: "index_librarians_on_users_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "university"
    t.string "location"
    t.integer "max_days"
    t.float "fines"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "books_id"
    t.bigint "{:foreign_key=>{:to_table=>:books}}_id"
    t.bigint "users_id"
    t.index ["books_id"], name: "index_libraries_on_books_id"
    t.index ["users_id"], name: "index_libraries_on_users_id"
    t.index ["{:foreign_key=>{:to_table=>:books}}_id"], name: "index_libraries_on_{:foreign_key=>{:to_table=>:books}}_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "education"
    t.string "university"
    t.integer "max_books"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.index ["users_id"], name: "index_students_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "university"
    t.integer "role"
    t.bigint "libraries_id"
    t.bigint "students_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["libraries_id"], name: "index_users_on_libraries_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["students_id"], name: "index_users_on_students_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "users", column: "users_id"
  add_foreign_key "book_request", "books", column: "books_id"
  add_foreign_key "book_request", "librarians", column: "librarians_id"
  add_foreign_key "book_request", "students", column: "students_id"
  add_foreign_key "books", "libraries", column: "libraries_id"
  add_foreign_key "libraries", "users", column: "users_id"
  add_foreign_key "students", "users", column: "users_id"
  add_foreign_key "users", "libraries", column: "libraries_id"
  add_foreign_key "users", "students", column: "students_id"
end
