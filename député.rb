require 'nokogiri'
require 'open-uri'

def origin
    puts "---------------------Liste of Députés of France-------------------"
    page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=576"))
    return page

end


def names(data)
    names_array = []
    names = data.xpath ('//*[@class="titre_normal"]')
    for i in 0..names.length-1 do
        names_array << names[i].text
    end
    return names_array
end
    


def mail_list(data)
mail_list_array = []
mail_list = data.xpath('//a[1][contains(@href,"mailto")]')
for i in 0..mail_list.length-1 do
    mail_list_array << mail_list[i].text
end
return mail_list_array
end

def result(names,mails)
    result = []
    for i in 0..names.length-1 do
        result << [{names[i] => mails[i]}]
    end
    puts result
    return result
end

def perform
    dat = origin
    names = names(dat)
    mails = mail_list(dat)
    result(names,mails)
end
perform