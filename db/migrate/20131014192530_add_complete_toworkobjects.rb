class AddCompleteToworkobjects < ActiveRecord::Migration
  def change
    add_column :workobjects, :complete, :integer, :default => 0
  end

end
