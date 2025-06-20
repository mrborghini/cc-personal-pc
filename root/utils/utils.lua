SERVER_URL = "phone-norfolk.gl.at.ply.gg:54306"

-- Splits a string and returns a table of strings
function SplitStr(inputstr, sep)
  -- if sep is null, set it as space
  if sep == nil then
    sep = '%s'
  end
  -- define an array
  local t = {}
  -- split string based on sep
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)')
  do
    -- insert the substring in table
    table.insert(t, str)
  end
  -- return the array
  return t
end

-- Performs a GET request.
-- Returns: err (string|nil), response (string|nil)
--   err: Error message if the request fails, otherwise nil.
--   response: Response body if successful, otherwise nil.
function GetRequest(url, headers)
    http.request(url, nil, headers)
    local event, requestedUrl, handle
    repeat
        event, requestedUrl, handle = os.pullEvent()
    until (event == "http_success" or event == "http_failure") and requestedUrl == url

    if event == "http_failure" then
        return handle, nil
    end

    local content = handle.readAll()
    handle.close()
    return nil, content
end

-- Performs a PATCH request.
-- Returns: err (string|nil), response (string|nil)
--   err: Error message if the request fails, otherwise nil.
--   response: Response body if successful, otherwise nil.
function PatchRequest(url, body, headers)
    http.request({ url = url, headers = headers, method = "PATCH", body = body })
    local event, requestedUrl, handle
    repeat
        event, requestedUrl, handle = os.pullEvent()
    until (event == "http_success" or event == "http_failure") and requestedUrl == url

    if event == "http_failure" then
        return handle, nil
    end

    local content = handle.readAll()
    handle.close()
    return nil, content
end

-- Performs a POST request.
-- Returns: err (string|nil), response (string|nil)
--   err: Error message if the request fails, otherwise nil.
--   response: Response body if successful, otherwise nil.
function PostRequest(url, body, headers)
    http.request(url, body, headers)
    local event, requestedUrl, handle
    repeat
        event, requestedUrl, handle = os.pullEvent()
    until (event == "http_success" or event == "http_failure") and requestedUrl == url

    if event == "http_failure" then
        return handle, nil
    end

    local content = handle.readAll()
    handle.close()
    return nil, content
end

-- Saves a file 
function SaveFile(path, content)
  local dirs = SplitStr(path, "/")
  local correctedPath = ""

  for i = 1, #dirs - 1 do
    local dir = dirs[i]
    correctedPath = correctedPath .. "/" .. dir
    fs.makeDir(correctedPath)
  end

  -- Append the file name
  correctedPath = correctedPath .. "/" .. dirs[#dirs]
  local file = fs.open(correctedPath, "w")
  file.write(content)
  file.close()
end

function ReadFile(path)
  local file = fs.open(path, "r")
  if file == nil then
    return nil
  end
  local content = file.readAll()
  file.close()
  return content
end

function DownloadFile(url, path)
    local err, response = GetRequest(url)
    if err ~= nil then
        return err
    end
    SaveFile(path, response)
end

-- This function will show a progress bar
function ShowProgressBar(done, total, message)
    -- Check if the amount done is bigger than the total
    if done > total then
        print("The amount of done cannot be bigger than the total amount")
        return
    end
    local length = 16 -- This is the length of the bar
    -- calculate the percentage
    local percentage = math.floor(done / total * 100)
    -- calculate the amount of hashtags based on the percentage
    local numHashtags = math.floor(length * percentage / 100)
    -- Calculate the amount of dashes
    local numDashes = length - numHashtags

    -- Store the final string
    local finalString = ""

    -- Loop over the amount of hashtags and add them to the string
    for _ = 1, numHashtags do
        finalString = finalString .. "#"
    end

    -- Same thing for the dashes
    for _ = 1, numDashes do
        finalString = finalString .. "-"
    end

    -- Clear the current line the cursor is on
    term.clearLine()

    -- Store the y axis of the cursor
    local _, y = term.getCursorPos()

    -- Keep the cursor at the beginning of the line at the current height
    term.setCursorPos(1, y)

    local progressString = string.format("[%s] %d%%", finalString, percentage)

    if message ~= nil then
        progressString = string.format("%s %s", progressString, message)
    end

    -- Show the progress bar
    write(progressString)
end
