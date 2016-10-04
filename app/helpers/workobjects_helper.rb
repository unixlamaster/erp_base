# -*- encoding : utf-8 -*-
module WorkobjectsHelper
  def color_for_fontbg_hash
    Hash[0,"red",20,"orange",40,"yellow",60,"darkorange",80,"green",100,"lightblue" ]
  end
  def workobject_status_list
    [["Договор","dogovor"],["Реализация","run"],["Закрытие","close"]].each {|st| yield st }
  end
  def workobject_status_hash
    { "dogovor" => "Договор", "run" => "Реализация", "close" => "Закрытие" }
  end
  
  def workobject_type_array
   [["Объект заказчика","Объект заказчика"],["Офис","Офис"]]
  end
  def workobject_job_hands
   [["Фирма","Фирма"],["Субподряд","Субподряд"]]
  end
end
