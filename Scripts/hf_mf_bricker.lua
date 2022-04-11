local getopt = require('getopt')
local ansicolors = require('ansicolors')

copyright = ''
author = 'Equip'
version = 'v1.0.5'
desc = [[
murders mifare classic 1k cards. 4k support coming when i can be bothered. keyfile support too. 
]]
example = [[
    1. script run hf_mf_bricker

]]
usage = [[
script run hf_mf_bricker [-h]
]]
arguments = [[
    -h      this help
]]

local function oops(err)
    print('ERROR:', err)
    core.clearCommandBuffer()
    return nil, err
end

local function help()
    print(copyright)
    print(author)
    print(version)
    print(desc)
    print(ansicolors.cyan..'Usage'..ansicolors.reset)
    print(usage)
    print(ansicolors.cyan..'Arguments'..ansicolors.reset)
    print(arguments)
    print(ansicolors.cyan..'Example usage'..ansicolors.reset)
    print(example)
end

local function bigbrick()
    local arr = {}
    for i = 1, 63 do
        local blk = 1 + (1*i)
        arr[i] = 'hf mf wrbl --blk '..blk..' -d FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF -k ffffffffffff -a'
    end
    return arr

end
local function sendCmds( cmds )
    for i = 0, #cmds do
        if cmds[i]  then
            print ( cmds[i]  )
            core.console( cmds[i] )
            core.clearCommandBuffer()
        end
    end
end


function main(args)

    local i
    local cmds = {}

    for o, a in getopt.getopt(args, 'h') do
        if o == 'h' then return help() end
    end

    core.clearCommandBuffer()
        sendCmds( bigbrick() )
end

main(args)
