class CreatePreliminaryOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :preliminary_orders do |t|
      t.string :name
      t.string :description
      t.string :quantity
      t.float :unit_cost
      t.belongs_to :service
      t.belongs_to :sample_method
      t.belongs_to :sample_category
      t.timestamps
    end
  end
end
