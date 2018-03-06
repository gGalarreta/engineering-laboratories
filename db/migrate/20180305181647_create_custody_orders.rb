class CreateCustodyOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :custody_orders do |t|
      t.string :subject
      t.references :employee
      t.references :supervisor
      t.references :service
      t.integer :custody_progress
      t.text :supervisor_observation
      t.boolean :supervised_validation , default: true
      t.integer :revision_number

      t.timestamps
    end
  end
end
