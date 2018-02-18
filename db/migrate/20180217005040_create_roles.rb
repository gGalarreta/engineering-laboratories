class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.belongs_to :laboratory
      t.timestamps
    end
  end
end
