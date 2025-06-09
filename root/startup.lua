function Main()
    -- Clear the default motd
    term.setCursorPos(1, 1)
    term.setBackgroundColor(32768)
    term.setTextColor(1)
    term.clear()

    -- Set aliases
    require("/alias")

    -- Run the commands on startup
    shell.run("utils/update-update-tool.lua")

    shell.run("startanim")
    print()
    shell.run("ascii")
    print()
    shell.run("quote", "--faster-eye-candy")
end

Main()
