# -*- encoding : utf-8 -*-
module ContractsHelper
  def contract_status_list
    ["Договор","Реализация","Закрытие"]
  end

  def contract_wo_hash(wo_all,contract)
    Hash[*(wo_all.each.collect {|wo| [wo.id,wo.name] if wo.contract.to_i==contract.to_i}.compact.flatten)]
  end
end
