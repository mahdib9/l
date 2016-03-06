do

local function run(msg, matches)
  if matches[1] == 'me' or 'من کیم'  or 'من کیم؟؟؟'then
    if is_sudo(msg) then
    send_document(get_receiver(msg), "./rank/sudo.webp", ok_cb, false)
      return "شما سازنده ربات هستید"
    elseif is_admin(msg) then
    send_document(get_receiver(msg), "./rank/admin.webp", ok_cb, false)
      return "شما ادمین گلوبال ربات هستید"
    elseif is_owner(msg) then
    send_document(get_receiver(msg), "./rank/owner.webp", ok_cb, false)
      return "شما صاحب گروه هستید"
    elseif is_momod(msg) then
    send_document(get_receiver(msg), "./rank/mod.webp", ok_cb, false)
      return "شما مدیر گروه هستید"
    else
      return "شما کاربر معمولی هستید"
  end
end
end

return {
  patterns = {
    "^[!/]([Mm]e)$",
    "^([Mm]e)$",
    "^من کیم؟"
    },
  run = run
}
end
