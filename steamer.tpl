// Arma3 steamcmd script
//
@ShutdownOnFailedCommand 1 //set to 0 if updating multiple servers at once
@NoPromptForPassword 1
//login <username> <password>
//for servers which don't need a login
login REPLACEME_USERNAME REPLACEME_PASSWORD
force_install_dir ./arma3/
app_update 233780 validate
quit
