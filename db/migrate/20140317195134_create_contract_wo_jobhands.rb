class CreateContractWoJobhands < ActiveRecord::Migration
  def change
    create_table :contract_wo_jobhands do |t|
      t.references :contract
      t.references :workobject
      t.string :job_hands
      t.string :status

      t.timestamps
    end
    add_index :contract_wo_jobhands, :contract_id
    add_index :contract_wo_jobhands, :workobject_id
  end
end
