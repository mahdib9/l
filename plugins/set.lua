local function save_value(msg, name, value)
  if (not name or not value) then
    return "روش اجرا: \n!set name value"
  end
  local hash = nil
  if msg.to.type == 'chat' then
    hash = 'chat:variables'
  end
  if hash then
    redis:hset(hash, name, value)
    return name.." ذخیره شد "
  end
end
local function run(msg, matches)
  if not is_sudo(msg) then
    return "شما دسترسی ندارید"
  end
  local name = string.sub(matches[1], 1, 10)
  local value = string.sub(matches[2], 1, 100000000)
  local name1 = user_print_name(msg.from)
  savelog(msg.to.id, name1.." ["..msg.from.id.."] saved ["..name.."] as > "..value )
  local text = save_value(msg, name, value)
  return text
end

return {
  patterns = {
   "^[!/]cc ([^%s]+) (.+)$"
  }, 
  run = run 
}

