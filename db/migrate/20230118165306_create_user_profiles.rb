class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.date :birthday
      t.string :gender
      t.text :bio
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
