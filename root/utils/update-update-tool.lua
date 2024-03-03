require ("/utils/downloadfile")

function Main()
    fs.delete("rm /update.lua")
    DownloadFile("wget https://raw.githubusercontent.com/lamborghinigamer1/cc-personal-pc/master/root/update.lua", "")
end

Main()
