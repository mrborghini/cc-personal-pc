function Main()
    -- Clear the default motd
    term.clear()
    term.setCursorPos(1, 1)

    -- Set aliases
    require("/alias")

    -- Run the commands on startup
    shell.run("utils/update-update-tool.lua")
    
    shell.run("startanim")
    print()
    shell.run("ascii")
    print()
    shell.run("quote", "--no-eye-candy")
end

Main()
