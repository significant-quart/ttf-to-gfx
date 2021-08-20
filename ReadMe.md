# .TTF to GFX Automation Script
---
### Installation
1. Clone this repository.
2. Download ``luvit`` (Lua JIT Compiler, i.e. NodeJS of Lua) from [here](https://luvit.io/install.html) and place the executables in the cloned folder.
3. Execute the following command(s):

``lit install creationix/coro-spawn``

4. Download the ``swfmill.exe`` CLI/CLT from [here](https://www.swfmill.org/) and place the executable in the cloned folder.
5. Download ``gfxexport.exe`` CLI/CLT from ~~[here]() and the required dynamic link libraries~~. You must find this yourself as it is apparently illegal to inform you of such information. Use your preferred search engine.
---
### How to use
1. Simple place all your ``.ttf`` files in the cloned folder.
2. Using your command line run the command:
``luvit s.lua``
3. With informative output you should see ``.gfx`` files popup up as the ``.ttf`` files are converted.
4. Stream them to FiveM as you would and register these fonts via a script, here's an example in Lua ([original](https://forum.cfx.re/t/fivem-update-may-5th-6th-2017/18200)):
```lua
local fontId

Citizen.CreateThread(function()
    RegisterFontFile('out') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('Fira Sans') -- the name from the .xml

    while true do
        Wait(0)
        SetTextFont(fontId)
        BeginTextCommandDisplayText('STRING')
        AddTextComponentString('Hello, world!')
        EndTextCommandDisplayText(0.5, 0.5)
    end
end)
```
---
![Preview](https://i.imgur.com/N5pTo4Y.gif)