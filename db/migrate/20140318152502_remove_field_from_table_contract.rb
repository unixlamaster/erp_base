class RemoveFieldFromTableContract < ActiveRecord::Migration
  def up
    remove_column :contracts, :job_hands
    remove_column :contracts, :status
  end

  def down
    add_column :contracts, :status, :string
    add_column :contracts, :job_hands, :string
  end
end
