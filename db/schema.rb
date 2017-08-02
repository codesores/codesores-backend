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

ActiveRecord::Schema.define(version: 20170802202931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issue_analyses", force: :cascade do |t|
    t.integer "validity_indicator"
    t.integer "complexity_indicator"
    t.integer "scope_indicator"
    t.integer "request_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string "title"
    t.string "labels"
    t.datetime "issue_created_at"
    t.integer "comment_count"
    t.string "url"
    t.string "body"
    t.string "author"
    t.integer "participant_count"
    t.integer "assignee_count"
    t.integer "repo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "request_type_id"
    t.string "repo_name"
    t.integer "stars_count", default: 0
  end

  create_table "languages", force: :cascade do |t|
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repos", force: :cascade do |t|
    t.string "name"
    t.string "owner"
    t.integer "language_id"
    t.string "description"
    t.integer "stargazers_count"
    t.integer "issues_count"
    t.integer "pull_request_count"
    t.string "url"
    t.integer "forks_count"
    t.datetime "repo_updated_at"
    t.integer "contributors_count"
    t.integer "mentionable_user_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_types", force: :cascade do |t|
    t.string "scope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stars", force: :cascade do |t|
    t.integer "user_id"
    t.integer "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_feedbacks", force: :cascade do |t|
    t.integer "validity"
    t.integer "difficulty"
    t.integer "user_id"
    t.integer "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "request_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_url"
    t.string "html_url"
    t.datetime "user_created_at"
    t.integer "public_repos"
  end

end
