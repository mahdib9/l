do

function run(msg, matches)
      fwd_msg('chat#id'..msg.to.id,'261809',ok_cb,false)
end 
return {
  description = "Invite bot into a group chat", 
  usage = "!join [invite link]",
  patterns = {
    "^[!/]version",

  },
  run = run
}
end
