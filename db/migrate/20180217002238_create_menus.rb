class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string :navigation_name
      t.string :controller_name
      t.string :icon
      t.timestamps
    end
  end
end
