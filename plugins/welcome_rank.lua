   local function run(msg, matches)
    if msg.action.type == "chat_add_user_link" then
  local hash = 'rank:variables'
  local text = ''
    local value = redis:hget(hash, msg.from.id)
     if not value then
        if msg.from.id == tonumber(mina) then 
           text = text..'سلام \n\n'
         elseif is_admin2(msg.from.id) then
           text = text..'سلام \n\n'
         elseif is_owner2(msg.from.id, msg.to.id) then
           text = text..'سلام \n\n'
         elseif is_momod2(msg.from.id, msg.to.id) then
           text = text..'سلام \n\n'
     else
           text = text..'سلام\n\n'
      end
      else
       text = text..'سلام '..value.. "\nبه گروه " ..string.gsub(msg.to.print_name, "_", " ").." خوش اومدی\n\n"
     end
return text
 end    
end
return {
  patterns = {
    "^!!tgservice (chat_add_user_link)$",

  }, 
  run = run 
}
