class AddLaboratoryRoleToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :laboratory, index: true
    add_reference :users, :role, index: true
  end
end
