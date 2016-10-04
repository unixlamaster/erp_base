# -*- encoding : utf-8 -*-
module TasksHelper


  def task_status_hash
    Hash['3new','Новая','2run','Выполняется','1end','Выполнена']
  end

  def task_priority_hash
    Hash['current','Текущая','burn','Горящая']
  end

  def task_list(state)
    case (state)
      when "3new"
        'Новые задачи'
      when '2run'
        'Текущие задачи'
      when '1end'
        'Выполненные задачи'
      when 'delegate'
        'Делегированные задачи'
      when 'all'
        'Все задачи'
      else
        'Новые задачи'
    end
  end

  def period_parser(period,date)
    wdays = ["каждое воскресение","каждый понедельник","каждый вторник","каждую среду","каждый четверг","каждую пятницу","каждую субботу","каждое воскресение"]
    case period
     when "Еженедельно"
       wdays[date.wday]
     when "Ежемесячно"
       "#{date.day}-го числа"
     else
       ""
    end
  end

end
