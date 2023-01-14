class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :body
      t.string :status
      t.check_constraint "status IN ('read', 'unread', 'dismissed')",
        name: "notification_status"

      t.timestamps
    end
  end
end
