local getopt = require('getopt')
local ansicolors = require('ansicolors')

copyright = ''
author = 'Equip'
version = 'v1.0.2'
desc = [[
This is a script that will set all blocks after 5 to`00000000 essentially "wiping" an NTAG i2c tag. wipes all 2k even though userdata is only 1k 
]]
example = [[
    1. script run hf_14a_i2cwipe

]]
usage = [[
script run hf_14a_i2cwipe [-h]
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

local function i2wipe()
    local arr = {}
    for i = 6, 248 do
        local blk = 1 + (1*i)
        arr[i] = 'hf mfu wrbl -b '..blk..' -d 00000000'
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
        sendCmds( i2wipe() )
end

main(args)
