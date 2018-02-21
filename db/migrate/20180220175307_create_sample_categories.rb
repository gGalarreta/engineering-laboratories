class CreateSampleCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :sample_categories do |t|
      t.string :name
      t.string :description
      t.boolean :active, default: true
      t.belongs_to :laboratory
      t.timestamps
    end
  end
end
