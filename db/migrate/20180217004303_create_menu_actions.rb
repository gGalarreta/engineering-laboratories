class CreateMenuActions < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_actions do |t|
      t.belongs_to :menu, index: true
      t.belongs_to :role, index: true
      t.boolean :create
      t.boolean :edit
      t.boolean :view
      t.boolean :status      
      t.timestamps
    end
  end
end
