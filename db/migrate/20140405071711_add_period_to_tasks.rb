class AddPeriodToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :period, :string
  end
end
