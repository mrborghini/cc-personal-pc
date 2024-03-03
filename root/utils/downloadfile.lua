function DownloadFile(url, directory)
    local filename = url:match("([^/]+)$")

    local request = http.get(url)

    if directory == nil then
        directory = "./"
    end

    if request then
        local file = fs.open(directory .. "/" .. filename, "w")

        local data = request.readAll()

        file.write(data)

        file.close()
    end
end
