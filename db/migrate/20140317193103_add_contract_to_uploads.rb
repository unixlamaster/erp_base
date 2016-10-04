class AddContractToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :contract_id, :integer
  end
end
