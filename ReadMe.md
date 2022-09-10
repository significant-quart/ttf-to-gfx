# ttf-to-gfx

**Luvit script to convert TrueType Fonts to Scaleform GFx for use in FiveM**

## Installation
1. Clone this repository.
2. Download [Luvit](https://luvit.io/install.htm) and place the executables (``lit``, ``luvi``, ``luvit``) in the repository folder. You can also place these executables in a common directory and amend them to your environment variables for use in your preferred CLI.
3. Run the following in your preferred  CLI:

    ``lit install creationix/coro-spawn``

4. Download the [swfmill](https://www.swfmill.org/) CLT and place in repository folder.
5. Download [gfxexport](https://sourceforge.net/projects/btek-kingfish/files/CryENGINE%20Modded/Tools/GFxExport/) along with the required dynamic link libraries (``zlib1.dll``, ``libtiff3.dll``, ``jpeg62.dll``) and place in repository folder.

## How to use
1. Place  TrueType Font (``.ttf``) files in the repository folder.
2. Using your preferred  CLI run the command:
``luvit main.lua``.
3. With informative output you should see Scaleform GFx ``.gfx`` files be created.
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

## Preview
![Preview](https://i.imgur.com/N5pTo4Y.gif)