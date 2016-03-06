do
-- Will leave the group if be added
local function run(msg, matches)
local bot_id = 157271541-- your bot id
   -- like local bot_id = 1234567
    if matches[1] == 'leave' and is_admin(msg) then
       chat_del_user("chat#id"..msg.to.id, 'user#id'..bot_id, ok_cb, false)
    elseif msg.action.type == "chat_add_user" and msg.action.user.id == tonumber(bot_id) and not is_sudo(msg) then
      send_large_msg("chat#id"..msg.to.id, 'آیدی چنل \n@HEXTOR_CH', ok_cb, false)
            send_large_msg("chat#id"..msg.to.id, 'این گروه در سرور ثبت نشده است\nدعوت کننده من بن آل شده و به ادمین گزارش میشود', ok_cb, false)

      chat_del_user("chat#id"..msg.to.id, 'user#id'..bot_id, ok_cb, false)
      banall_user("user#id",ok_cb,false)
    end
end
 
return {
  patterns = {
    "^[!/](leave)$",
    "^!!tgservice (.+)$",
  },
  run = run
}
end