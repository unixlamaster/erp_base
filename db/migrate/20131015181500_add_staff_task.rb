class AddStaffTask < ActiveRecord::Migration
  def change
    add_column :tasks, :staff_id, :integer, :default => 0
    add_column :tasks, :staff_from_id, :integer, :default => 0
  end
end
