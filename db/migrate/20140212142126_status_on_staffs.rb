class StatusOnStaffs < ActiveRecord::Migration
  def change
  add_column :staffs, :status, :string
  end
end
