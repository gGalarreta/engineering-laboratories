class CreateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :features do |t|
      t.float :minimun_value, default:  0.00
      t.float :maximum_value, default:  0.00
      t.string :description
      t.belongs_to :samples_category_method
      t.timestamps
    end
  end
end
