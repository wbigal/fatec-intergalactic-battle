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

ActiveRecord::Schema.define(version: 2018_06_17_024343) do

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

  create_table "game_boards", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "match_id", null: false
    t.bigint "scenery_background_id", null: false
    t.boolean "ready_to_play", default: false, null: false
    t.integer "rows", null: false
    t.integer "columns", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_game_boards_on_match_id"
    t.index ["player_id", "match_id"], name: "index_game_boards_on_player_id_and_match_id", unique: true
    t.index ["player_id"], name: "index_game_boards_on_player_id"
    t.index ["scenery_background_id"], name: "index_game_boards_on_scenery_background_id"
  end

  create_table "game_boards_dropped_bombs", force: :cascade do |t|
    t.bigint "game_board_id", null: false
    t.bigint "game_boards_spacecraft_position_id"
    t.integer "row", null: false
    t.integer "column", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_board_id", "game_boards_spacecraft_position_id"], name: "uix_gb_dropped_bombs_on_gb_spacecraft_position_id", unique: true
    t.index ["game_board_id", "row", "column"], name: "ix_gb_dropped_bombs_on_game_board_and_row_and_column", unique: true
    t.index ["game_board_id"], name: "index_game_boards_dropped_bombs_on_game_board_id"
    t.index ["game_boards_spacecraft_position_id"], name: "ix_gb_dropped_bombs_on_gb_spacecraft_position_id"
  end

  create_table "game_boards_spacecraft_positions", force: :cascade do |t|
    t.bigint "game_board_id", null: false
    t.bigint "spacecraft_id", null: false
    t.integer "row", null: false
    t.integer "column", null: false
    t.boolean "targeted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_board_id", "row", "column"], name: "ix_gb_spacecraft_positions_on_game_board_and_row_and_column", unique: true
    t.index ["game_board_id"], name: "index_game_boards_spacecraft_positions_on_game_board_id"
    t.index ["spacecraft_id"], name: "index_game_boards_spacecraft_positions_on_spacecraft_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.integer "player_team_id", null: false
    t.integer "challenger_id"
    t.integer "challenger_team_id", null: false
    t.bigint "scenery_id", null: false
    t.integer "winner_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer "total_time_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 50, default: "awaiting_challenge", null: false
    t.index ["player_id"], name: "index_matches_on_player_id"
    t.index ["scenery_id"], name: "index_matches_on_scenery_id"
  end

  create_table "player_avatars", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_player_avatars_on_name", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.bigint "player_avatar_id", null: false
    t.string "nickname", limit: 20, null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["nickname"], name: "index_players_on_nickname", unique: true
    t.index ["player_avatar_id"], name: "index_players_on_player_avatar_id"
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  create_table "sceneries", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "rows", null: false
    t.integer "columns", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "scenery_background_id"
    t.index ["name"], name: "index_sceneries_on_name", unique: true
    t.index ["scenery_background_id"], name: "index_sceneries_on_scenery_background_id"
  end

  create_table "sceneries_scenery_backgrounds", id: false, force: :cascade do |t|
    t.bigint "scenery_id"
    t.bigint "scenery_background_id"
    t.index ["scenery_background_id"], name: "index_sceneries_scenery_backgrounds_on_scenery_background_id"
    t.index ["scenery_id", "scenery_background_id"], name: "ux_sceneries_scenery_backgrounds", unique: true
    t.index ["scenery_id"], name: "index_sceneries_scenery_backgrounds_on_scenery_id"
  end

  create_table "sceneries_spacecrafts", id: false, force: :cascade do |t|
    t.bigint "scenery_id"
    t.bigint "spacecraft_id"
    t.index ["scenery_id", "spacecraft_id"], name: "index_sceneries_spacecrafts_on_scenery_id_and_spacecraft_id", unique: true
    t.index ["scenery_id"], name: "index_sceneries_spacecrafts_on_scenery_id"
    t.index ["spacecraft_id"], name: "index_sceneries_spacecrafts_on_spacecraft_id"
  end

  create_table "scenery_backgrounds", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_scenery_backgrounds_on_name", unique: true
  end

  create_table "spacecraft_shapes", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "template_file_name"
    t.string "template_content_type"
    t.integer "template_file_size"
    t.datetime "template_updated_at"
    t.json "targets", null: false
    t.integer "spacecraft_width", null: false
    t.integer "spacecraft_height", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_spacecraft_shapes_on_name", unique: true
  end

  create_table "spacecrafts", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "spacecraft_shape_id", null: false
    t.string "name", limit: 50, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_spacecrafts_on_name", unique: true
    t.index ["spacecraft_shape_id"], name: "index_spacecrafts_on_spacecraft_shape_id"
    t.index ["team_id"], name: "index_spacecrafts_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_boards", "matches"
  add_foreign_key "game_boards", "players"
  add_foreign_key "game_boards", "scenery_backgrounds"
  add_foreign_key "game_boards_dropped_bombs", "game_boards"
  add_foreign_key "game_boards_dropped_bombs", "game_boards_spacecraft_positions"
  add_foreign_key "game_boards_spacecraft_positions", "game_boards"
  add_foreign_key "game_boards_spacecraft_positions", "spacecrafts"
  add_foreign_key "matches", "players"
  add_foreign_key "matches", "players", column: "challenger_id"
  add_foreign_key "matches", "players", column: "winner_id"
  add_foreign_key "matches", "sceneries"
  add_foreign_key "matches", "teams", column: "challenger_team_id"
  add_foreign_key "matches", "teams", column: "player_team_id"
  add_foreign_key "players", "player_avatars"
  add_foreign_key "sceneries", "scenery_backgrounds"
  add_foreign_key "sceneries_scenery_backgrounds", "sceneries"
  add_foreign_key "sceneries_scenery_backgrounds", "scenery_backgrounds"
  add_foreign_key "sceneries_spacecrafts", "sceneries"
  add_foreign_key "sceneries_spacecrafts", "spacecrafts"
  add_foreign_key "spacecrafts", "spacecraft_shapes"
  add_foreign_key "spacecrafts", "teams"
end
