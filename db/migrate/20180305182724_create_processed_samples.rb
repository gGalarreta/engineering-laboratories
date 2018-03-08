class CreateProcessedSamples < ActiveRecord::Migration[5.1]
  def change
    create_table :processed_samples do |t|
      t.string :pucp_code
      t.string :client_code
      t.text :description
      t.references :preliminary_order
      t.float :subtotal_cost
      t.float :discount
      t.references :custody_order
      t.text :classified_values

      t.timestamps
    end
  end
end
