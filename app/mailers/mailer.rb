# -*- encoding : utf-8 -*-
class Mailer < ActionMailer::Base
  include TasksHelper
  default from: "apella-rus@yandex.ru"
  def task_notification(staff_to,staff_from,task)
    @staff_to = staff_to
    @staff_from = staff_from
    @task = task

    mail(to: @staff_to.email, subject: "Поступила новая задача", bcc: ["unixlamaster@mail.ru"])
  end

  def not_found_report(wo)
    @wo=wo
        mail(to: "de@cettex.ru", subject: "Отсутствует отчет", bcc: ["unixlamaster@mail.ru"])
  end

  def task_expire_notification(task)
    @task=task
    mail(to: task.staff_to.email, subject: "Последний срок выполнения задачи - "+@task.description[0..15]+"...", bcc: ["unixlamaster@mail.ru"])
  end

  def task_expireds_alert(task)
    @task=task
    @task_state = task_status_hash[@task.state]
    @task_priority = task_priority_hash[@task.priority]
   mail(to: @task.staff_from.email, subject: "Просрочено выполнениe задачи - "+@task.description[0..15]+"...", bcc: ["unixlamaster@mail.ru","de@cettex.ru"])
  end

  def task_end_notification(task)
    @task=task
    mail(to: task.staff_from.email, subject: "Задача выполнена - "+@task.description[0..15]+"...", bcc: ["unixlamaster@mail.ru"])
  end

end
