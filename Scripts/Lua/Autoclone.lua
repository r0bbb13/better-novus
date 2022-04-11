local ansicolors = require('ansicolors')
local getopt = require('getopt')


local function Help()
    local function ColourOptions(option)
        if option == 1 then return ansicolors.red..ansicolors.underscore end
        if option == 2 then return ansicolors.red end
    end


    -- Author
    print("MrBuushy")
    -- Version
    print("v1.0.1")
    -- Description
    print("This script runs through different Mifare attacks, Dumps the files, renames them and then loads it to a new card\n\n")
    -- Main Command
    print(ColourOptions(1)..'Usage'..ansicolors.reset)
    print([[
        script run hf_mf_cardcloner.lua [-h] [-f <fn>] [-g <gen>]
    ]])
    -- Arguments
    print(ColourOptions(1)..'Arguments'..ansicolors.reset)
    print([[
        NEW CARD GENERATION:
        -1               Magic Generation 1a (Default)
        -2               Magic Generation 2
        OTHER:
        -h                This help
        -f <fn>           Filename of created dumps
    ]])
    -- Examples
    print(ColourOptions(1)..'Examples'..ansicolors.reset)
    print([[
        script run hf_mf_cardcloner.lua
        script run hf_mf_cardcloner.lua -h
        script run hf_mf_cardcloner.lua -f SecurityCard
        script run hf_mf_cardcloner.lua -2
        script run hf_mf_cardcloner.lua -f SecurityCard -1
    ]])
end


local function GetAllFiles()
    local FileList = {}
    for line in io.popen("dir"):lines() do
        if line:find("%.") then
            if not line:find("<DIR>") then
                table.insert(FileList, line:match("[^ ]+$"))
            end
        end
    end
    return FileList
end


local function CompareTables(NewTable, OldTable)
    local NewFiles = {}
    for index1, value1 in ipairs(NewTable) do
        local exists = false
        for index2, value2 in ipairs(OldTable) do
            if value1 == value2 then exists = true end
        end
        if exists == false then
            table.insert(NewFiles, value1)
        end
    end
    return NewFiles
end


local function DumpData(DumpFiles)
    for index, file in ipairs(DumpFiles) do
        if file:match("%.bin$") and file:find("dump") then
            local DumpFileName = string.sub(file, 1, -5)
            local DumpUID = string.sub(string.sub(DumpFileName, 7, -1), 1, (string.sub(DumpFileName, 7, -1)):find("-")-1)
            return DumpFileName, DumpUID
        end
    end
    return "", ""
end


local function WaitForResponse(msg)
    io.write(msg)
    local response = io.read()
    if response == "n" then return "cancel" end
    return ""
end


local function RunCommand(cmd)
    core.console(cmd)
    core.clearCommandBuffer()
end


local function Main()
    local Filename = None
    local Generation = 1
    for o, a in getopt.getopt(args, 'hf:12') do
        if o == 'h' then return Help() end
        if o == 'f' then Filename = a end
        if o == '1' then Generation = 1 end
        if o == '2' then Generation = 2 end
    end

    local OldFilesList = GetAllFiles()
    WaitForResponse("Original Card Placed? (press enter): ")
    RunCommand("hf mf autopwn")
    local NewFilesList = GetAllFiles()
    DumpFiles = CompareTables(NewFilesList, OldFilesList)
    local DumpFileName, DumpUID = DumpData(DumpFiles)
    if Filename ~= None then
        for index, extension in ipairs({"bin", "eml", "json"}) do
            os.remove(Filename.."."..extension)
            os.rename(DumpFileName.."."..extension, Filename.."."..extension)
        end
        print(ansicolors.cyan.."Renamed '"..DumpFileName.."' files to '"..Filename.."'"..ansicolors.reset)
        DumpFileName = Filename
    end
    if Generation == 2 then local NewCardMessage = "\nNew Gen2 Card Placed? (press enter to continue or 'n' to cancel): "
    else local NewCardMessage = "\nNew Gen1 Card Placed? (press enter to continue or 'n' to cancel): " end
    if WaitForResponse(NewCardMessage) ~= "cancel" then
        if Generation == 2 then RunCommand("hf mf restore -u "..DumpUID.." -f "..DumpFileName)
        elseif Generation == 1 then RunCommand("hf mf cload -f "..DumpFileName) end
    else
        print("Canceled")
    end
end


Main()
