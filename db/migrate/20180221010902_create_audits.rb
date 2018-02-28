class CreateAudits < ActiveRecord::Migration[5.1]
  def change
    create_table :audits do |t|
      t.string :author
      t.string :author_category
      t.string :action
      t.string :status
      t.string :action_reference
      t.timestamps
    end
  end
end
