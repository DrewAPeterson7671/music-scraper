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

ActiveRecord::Schema.define(version: 2022_07_04_162224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "album_name"
    t.integer "artist_id"
    t.integer "year"
    t.string "album_genre"
    t.string "album_priority"
    t.string "album_type"
    t.string "album_complete"
    t.string "album_download"
    t.string "current_album_song"
    t.string "album_version"
    t.string "download_verified"
    t.string "download_status"
    t.integer "rating"
    t.boolean "normalized_tagged"
    t.boolean "compiliation"
    t.string "album_sub_genre1"
    t.string "album_sub_genre2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "genre"
    t.string "subgenre1"
    t.string "subgenre2"
    t.string "subgenre3"
    t.string "priority"
    t.string "pop_list"
    t.string "greatest_list"
    t.string "current_album"
    t.string "current_song"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "album"
    t.string "to_download"
    t.string "download_type"
    t.date "download_date"
    t.string "download_status"
    t.string "wiki_page"
    t.string "discogs_page"
    t.string "current_download"
    t.string "dl_listen_album"
    t.string "dl_listen_song"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "welcomes", force: :cascade do |t|
    t.string "placeholder"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_welcomes_on_user_id"
  end

  add_foreign_key "albums", "artists"
end
