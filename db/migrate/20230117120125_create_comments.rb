class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.references :commenter, null: false, foreign_key: { to_table: :users }
      t.text :body

      t.timestamps
    end
  end
end
