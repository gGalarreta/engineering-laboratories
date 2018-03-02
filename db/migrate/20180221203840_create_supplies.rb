class CreateSupplies < ActiveRecord::Migration[5.1]
  def change
    create_table :supplies do |t|
      t.string :code
      t.string :name
      t.string :description
      t.float :quantity
      t.string :measure_unit
      t.belongs_to :laboratory

      t.timestamps
    end
  end
end
