class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :address
      t.integer :phone
      t.date :date_of_birth
      t.integer :gender

      t.timestamps
    end
  end
end
