local fs = require("fs")
local ChildProccess = require("coro-spawn")
local Timer = require("timer")

local F = string.format
local Template = [[
<?xml version="1.0" encoding="iso-8859-1" ?>
<movie version="8" width="320" height="240" framerate="12">
    <frame>
        <library>
            <font id="%s" import="%s" name="%s"/>
        </library>
    </frame>
</movie>
]]

coroutine.wrap(function()
    for File, _ in fs.scandirSync("./") do
        if File:sub(#File - 2, #File) == "ttf" then
            local FileName = File:sub(1, #File - 4)
            print("Beginning conversion proccess for:", File)
            
            fs.writeFileSync(F("%s.xml", FileName), F(Template, FileName, File, FileName))
            print("Wrote SWF XML for: ", File)

            ChildProccess("./swfmill.exe", {
                ["args"] = { "simple", F("%s.xml", FileName), F("%s.swf", FileName) },
                ["stdio"] = {0, 0, 0},
            })

            print("Awaiting SWF creation.")
            while not fs.existsSync(F("./%s.swf", FileName)) do
                Timer.sleep(1000)
            end

            print("Cleaning up...")
            fs.unlinkSync(F("./%s.xml", FileName))

            ChildProccess("./gfxexport.exe", {
                ["args"] = { F("./%s.swf", FileName) },
                ["stdio"] = {0, 0, 0},
            })

            print("Awaiting GFX creation.")
            while not fs.existsSync(F("./%s.gfx", FileName)) do
                Timer.sleep(1000)
            end
            
            print("Cleaning up...")
            fs.unlinkSync(F("./%s.swf", FileName))

            print(F("Conversion for %s ==> GFX finished.\n", File))
        end
    end

    print("Done!")
end)()