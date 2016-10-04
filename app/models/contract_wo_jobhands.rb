class ContractWoJobhands < ActiveRecord::Base
  belongs_to :contract
  belongs_to :workobject
  attr_accessible :job_hands, :status, :contract_id, :workobject_id
end
