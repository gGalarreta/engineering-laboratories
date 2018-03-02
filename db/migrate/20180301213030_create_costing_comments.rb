class CreateCostingComments < ActiveRecord::Migration[5.1]
  def change
    create_table :costing_comments do |t|
      t.string :description
      t.belongs_to :service
      t.timestamps
    end
  end
end
