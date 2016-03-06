local function run(msg, matches)

if msg.to.type == 'chat' then
    if is_owner(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['antifosh'] then
                lock_eng = data[tostring(msg.to.id)]['settings']['antifosh']
            end
            end end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_eng == "yes" then
      send_large_msg("chat#id".. msg.to.id , "الفاظ رکیک ممنوع است")
        chat_del_user(chat, user, ok_cb, true)
       end
  
   end  

end

return {patterns = {
"کونی",
"کیری",
"کص لیس",
"کسکش",
"کس کش",
"کونده",
"جنده",
"کس ننه",
"گاییدم",
"نگاییدم",
"بگا",
"گاییدن",
"ننه الکسیس",
"ننه زنا",
"ننه کیر دزد",
"زنازاده",
"مادر به خطا",
"کسمخ",
"کسخل",
"کسمغز",
"ننه خراب",
"کیرم دهنت",
"کیرم دهنتون",
"حروم زاده",
"فاک",
"فاک یو",
"قرومصاق",
"بی غیرت",
"کس ننت",
"جق",
"جقی",
"جق زن",
"شومبول",
"چوچول",
"چوچوله",
"دودول",
"ننه چس",
"چسی",
"کیر",
"کون",
"ننت",
"مادر جنده",
"کس عمت",
"kos",
"koon",
"mame",
"kos nant",
"kon nanat",
"madareto gayidam",
"ممه",
"nane",
"amat",
"jag",
"کسننت",
"کسعمت",
"کس عمت",
"چسی",
"چس ممبر",
"اوبی",
"قحبه",
"بسیک",
"سیکتر",
"سیک",
"خوارکسته"
}, run = run}

