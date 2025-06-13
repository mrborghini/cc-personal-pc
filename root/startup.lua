function main()
    -- Clear the default motd
    term.clear()
    term.setCursorPos(1, 1)

    -- Set aliases
    require("/alias")

    -- Run the commands on startup
    shell.run("start-anim")
    print()
    shell.run("ascii")
    print()
    shell.run("quote", "--faster-eye-candy")
end

main()
