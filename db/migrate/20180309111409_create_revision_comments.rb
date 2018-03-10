class CreateRevisionComments < ActiveRecord::Migration[5.1]
  def change
    create_table :revision_comments do |t|
      t.string :description
      t.belongs_to :custody_order

      t.timestamps
    end
  end
end
