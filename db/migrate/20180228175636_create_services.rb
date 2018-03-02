class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.date :pick_up_date
      t.float :total
      t.string :subject
      t.integer :progress
      t.boolean :active, default: true
      t.boolean :attended, default: true
      t.boolean :funded_validation, default: true
      t.references :client
      t.references :employee
      t.belongs_to :laboratory, index: true
      t.timestamps
    end
  end
end
