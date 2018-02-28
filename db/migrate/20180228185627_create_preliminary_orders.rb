class CreatePreliminaryOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :preliminary_orders do |t|
      t.string :name
      t.string :description
      t.string :quantity
      t.belongs_to :service
      t.timestamps
    end
  end
end
