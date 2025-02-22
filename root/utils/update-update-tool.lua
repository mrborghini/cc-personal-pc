require ("/utils/downloadfile")

function Main()
    fs.delete("rm /update.lua")
    DownloadFile("wget https://raw.githubusercontent.com/mrborghini/cc-personal-pc/master/root/update.lua", "")
end

Main()
