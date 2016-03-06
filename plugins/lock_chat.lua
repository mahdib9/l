antichat = {}-- An empty table for solving multiple kicking problem

do
local function run(msg, matches)
if msg.service then
    return
    end
  if is_momod(msg) then -- Ignore mods,owner,admins
    return
  end
  local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)]['settings']['lock_chat'] then
    if data[tostring(msg.to.id)]['settings']['lock_chat'] == 'yes' then
      if antichat[msg.from.id] == true then end
       send_large_msg("chat#id".. msg.to.id , "چت کردن ممنوع است")
      chat_del_user('chat#id'..msg.to.id,'user#id'..msg.from.id,ok_cb,false)
      antichat[msg.from.id] = false
      return
    end
  end
  return
end
local function cron()
  antichat = {} -- Clear antichat table 
end
return {
  patterns = {
    "(.+)"
    },
  run = run,
  cron = cron
}

end