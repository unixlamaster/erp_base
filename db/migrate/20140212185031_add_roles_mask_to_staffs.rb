class AddRolesMaskToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :roles_mask, :integer
  end
end
