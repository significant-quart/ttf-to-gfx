local FS = require("fs")
local ChildProccess = require("coro-spawn")
local Timer = require("timer")


local F = string.format
local TEMPLATE = [[
<?xml version="1.0" encoding="iso-8859-1" ?>
<movie version="8" width="1280" height="720" framerate="24">
    <frame>
        <library>
            <font id="%s" import="%s" name="%s"/>
        </library>
    </frame>
</movie>
]]


coroutine.wrap(function()
    for file, _ in FS.scandirSync("./") do
        if file:sub(#file - 2, #file) == "ttf" then
            local fileName = file:sub(1, #file - 4)
            print(F("Converting %s...", file))

            FS.writeFileSync(F("%s.xml", fileName), F(TEMPLATE, fileName, file, fileName))
            print("Written SWF XML...")

            ChildProccess("./swfmill.exe", {
                ["args"] = { "simple", F("%s.xml", fileName), F("%s.swf", fileName) },
                ["stdio"] = {0, 0, 0},
            })
            print("Exporing SWF XML...")

            print("Awaiting SWF creation..")
            while not FS.existsSync(F("./%s.swf", fileName)) do
                Timer.sleep(1000)
            end

            print("Cleaning up...")
            FS.unlinkSync(F("./%s.xml", fileName))

            ChildProccess("./gfxexport.exe", {
                ["args"] = { F("./%s.swf", fileName) },
                ["stdio"] = {0, 0, 0},
            })

            print("Awaiting GFX creation...")
            while not FS.existsSync(F("./%s.gfx", fileName)) do
                Timer.sleep(1000)
            end

            print("Cleaning up...")
            FS.unlinkSync(F("./%s.swf", fileName))

            print(F("Converted %s\n", file))
        end
    end

    print("\nDone!")
end)()