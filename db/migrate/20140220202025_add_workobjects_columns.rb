class AddWorkobjectsColumns < ActiveRecord::Migration
   def up
  change_table(:workobjects) do |t|
  t.string :job
  t.string :job_hands
  t.string :client
  t.string :contract
  end
end

def down
end

end
