class CreateStaffsRoles < ActiveRecord::Migration
  def change
    create_table :staffs_roles do |t|
      t.references :staff
      t.references :role

      t.timestamps
    end
    add_index :staffs_roles, :staff_id
    add_index :staffs_roles, :role_id
  end
end
