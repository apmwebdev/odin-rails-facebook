class RemoveStatusFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :friend_requests, :status, :string
  end
end
