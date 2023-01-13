class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users}
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false
      t.check_constraint "status IN ('pending', 'accepted', 'rejected')",
        name: "valid_status"

      t.timestamps
    end
  end
end
