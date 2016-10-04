# -*- encoding : utf-8 -*-
require 'net/http'
require 'cgi'

module SendSmsHelper

  def send_sms(task)
    keyapi = IO.readlines("#{Rails.root}/sms_key_api")[0].chomp
    url = "http://sms.ru/sms/send?api_id=#{keyapi}&to=#{task.staff_to.phone1}&text="+CGI.escape('Вам поступила новая задача от '+task.staff_from.fullname)
    Net::HTTP.get(URI(url))[0]
  end
end
