class CreateLaboratories < ActiveRecord::Migration[5.1]
  def change
    create_table :laboratories do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.string :description
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
