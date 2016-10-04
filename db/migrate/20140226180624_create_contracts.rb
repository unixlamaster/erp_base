class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :id
      t.string :region
      t.string :client
      t.string :name
      t.string :c_number
      t.date :c_date
      t.integer :staff_id
      t.string :job_hands
      t.string :status

      t.timestamps
    end
  end
end
