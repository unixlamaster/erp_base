module PostsHelper
 def workobject2select
    ar=[]
    Workobject.all.collect {|wo| ar.push([wo.name+", "+wo.city+", "+wo.address,wo.id]) }
    ar
 end

 def trbr(str)
   str.nil? ? "" : str.gsub(/\n/, '<br>').html_safe
 end
end
