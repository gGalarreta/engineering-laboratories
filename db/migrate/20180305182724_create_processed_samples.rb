class CreateProcessedSamples < ActiveRecord::Migration[5.1]
  def change
    create_table :processed_samples do |t|
      t.text :description
      t.text :classified_values
      t.float :discount
      t.float :subtotal_cost
      t.string :pucp_code
      t.string :client_code
      t.references :preliminary_order
      t.references :custody_order
      t.references :service
      t.timestamps
    end
  end
end
