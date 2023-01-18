class MakeUserProfileUserIndexUnique < ActiveRecord::Migration[7.0]
  def change
    remove_index :user_profiles, :user_id
    add_index :user_profiles, :user_id, unique: true
  end
end
