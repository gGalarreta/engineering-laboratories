class CreateSamplesCategoryMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :samples_category_methods do |t|
      t.belongs_to :sample_category
      t.belongs_to :sample_method
      t.timestamps
    end
  end
end
