# -*- encoding : utf-8 -*-
module StaffobjectjournalsHelper
  def staff_obj_status_hash
    Hash["worked","Работал","absence","Прогул","sick","Больничный","leave","Отпуск","work","Работает","sack","Уволен"]
  end
 
  def staff_obj_status_collect
    [["Работал","worked"],["Прогул","absence"],["Больничный","sick"],["Отпуск","leave"],["Работает","work"],["Уволен","sack"]]
  end
end
