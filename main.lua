-- main.lua
print("🟢 Loading Hat Orbit Modules...")

local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/yeming360/Orbit-hat-2.0-update/main/core.lua"))()
print("✅ Core loaded")

local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/yeming360/Orbit-hat-2.0-update/main/gui.lua"))()
print("✅ GUI loaded")

local Wing = loadstring(game:HttpGet("https://raw.githubusercontent.com/yeming360/Orbit-hat-2.0-update/main/wing.lua"))()
print("✅ Wing loaded")

Core.Init(GUI, Wing)
print("🔥 Hat Orbit v9.9.8 Fully Loaded!")
