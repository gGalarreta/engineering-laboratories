class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.date :date_of_birth
      t.string :ruc
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address
      t.string :contact_person
      t.integer :gender
      t.integer :category
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
