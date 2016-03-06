do
data = load_data(_config.moderation.data)
local function get_msgs_user_chat(user_id, chat_id)
  local user_info = {}
  local uhash = 'user:'..user_id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..user_id..':'..chat_id
  user_info.msgs = tonumber(redis:get(um_hash) or 0)
  user_info.name = user_print_name(user)..' ['..user_id..']'
  return user_info
end
local function chat_stats(chat_id)
  local hash = 'chat:'..chat_id..':users'
  local users = redis:smembers(hash)
  local users_info = {}
  for i = 1, #users do
    local user_id = users[i]
    local user_info = get_msgs_user_chat(user_id, chat_id)
    table.insert(users_info, user_info)
  end
  table.sort(users_info, function(a, b) 
      if a.msgs and b.msgs then
        return a.msgs > b.msgs
      end
    end)
  local text = 'وضعیت گروه:\n'
  for k,user in pairs(users_info) do
    text = text..user.name..' = '..user.msgs..'\n'
  end
  return text
end

local function get_group_type(target)
  local data = load_data(_config.moderation.data)
  local group_type = data[tostring(target)]['group_type']
    if not group_type or group_type == nil then
       return 'نوع گروه مشخص نیست'
    end
      return group_type
end
local function show_group_settings(target)
  local data = load_data(_config.moderation.data)
  if data[tostring(target)] then
    if data[tostring(target)]['settings']['flood_msg_max'] then
      NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
      print('custom'..NUM_MSG_MAX)
    else 
      NUM_MSG_MAX = 5
    end
  end
  local settings = data[tostring(target)]['settings']
  local text = "قفل نام : "..settings.lock_name.."\nقفل عکس: "..settings.lock_photo.."\nقفل عضوگیری "..settings.lock_member.."\nآنتی اسپم : "..NUM_MSG_MAX
  return text
end

local function get_description(target)
  local data = load_data(_config.moderation.data)
  local data_cat = 'description'
  if not data[tostring(target)][data_cat] then
    return 'توضیحی تنظیم نشده است'
  end
  local about = data[tostring(target)][data_cat]
  return about
end

local function get_rules(target)
  local data = load_data(_config.moderation.data)
  local data_cat = 'rules'
  if not data[tostring(target)][data_cat] then
    return 'قانونی تنظیم شده است'
  end
  local rules = data[tostring(target)][data_cat]
  return rules
end


local function modlist(target)
  local data = load_data(_config.moderation.data)
  local groups = 'groups'
  if not data[tostring(groups)] or not data[tostring(groups)][tostring(target)] then
    return 'گروه در سرور اضافه نشده است\nیا گروه ادمین است'
  end
  if next(data[tostring(target)]['moderators']) == nil then
    return 'لیست مدیران \n_____________________________\nدرحال حاضر مدیری وجود ندارد.\nصاحب گروه مجزا است'
  end
  local i = 1
  local message = '\nList of moderators :\n'
  for k,v in pairs(data[tostring(target)]['moderators']) do
    message = message ..i..' - @'..v..' [' ..k.. '] \n'
    i = i + 1
  end
  return message
end

local function get_link(target)
  local data = load_data(_config.moderation.data)
  local group_link = data[tostring(target)]['settings']['set_link']
  if not group_link or group_link == nil then 
    return "لینکی وجود ندارد"
  end
  return "لینک دعوت به گروه:\n"..group_link
end

local function all(target, receiver)
  local text = "تمامی تنظیمات و وضعیت گروه بدین شرح است\n\n"
  local group_type = get_group_type(target)
  text = text.."نوع گروه: \n"..group_type
  local settings = show_group_settings(target)
  text = text.."\nاتظیمات گروه: \n"..settings
  local rules = get_rules(target)
  text = text.."\nقوانین: \n"..rules
  local description = get_description(target)
  text = text.."\nتوضیحات: \n"..description
  local modlist = modlist(target)
  text = text.."\nمدیران: \n"..modlist
  local link = get_link(target)
  text = text.."\nلینک گروه: \n"..link
  local stats = chat_stats(target)
  text = text.."\n"..stats
  local ban_list = ban_list(target)
  text = text.."\n"..ban_list
  local file = io.open("./groups/all/"..target.."all.txt", "w")
  file:write(text)
  file:flush()
  file:close()
  send_document(receiver,"./groups/all/"..target.."all.txt", ok_cb, false)
  return
end

function run(msg, matches)
  if matches[1] == "all" and matches[2] and is_owner2(msg.from.id, matches[2]) then
    local receiver = get_receiver(msg)
    local target = matches[2]
    return all(target, receiver)
  end
  if not is_owner(msg) then
    return
  end
  if matches[1] == "all" and not matches[2] then
    local receiver = get_receiver(msg)
    if not is_owner(msg) then
      return
    end
    return all(msg.to.id, receiver)
  end
end


return {
  patterns = {
  "^[!/](all)$",
  "^[!/](all) (%d+)$"
  },
  run = run
}
end