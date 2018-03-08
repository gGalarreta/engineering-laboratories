class CreateSystemParameters < ActiveRecord::Migration[5.1]
  def change
    create_table :system_parameters do |t|
      t.integer :feature
      t.text :description
      t.belongs_to :laboratory

      t.timestamps
    end
  end
end
