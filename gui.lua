-- gui.lua (COMPLETE - All Features)
local GUI = {}

function GUI.Create(Core)
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local plr = Players.LocalPlayer
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HatOrbitUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = plr:WaitForChild("PlayerGui")
    
    local main = Instance.new("Frame", screenGui)
    main.Size = UDim2.new(0, 280, 0, 600)
    main.Position = UDim2.new(0.5, -140, 0.5, -300)
    main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    main.BackgroundTransparency = 0.08
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    
    local uiScale = Instance.new("UIScale", main)
    uiScale.Scale = Core.GUI_SCALE
    
    local bar = Instance.new("Frame", main)
    bar.Size = UDim2.new(1, 0, 0, 34)
    bar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    bar.BorderSizePixel = 0
    bar.ZIndex = 2
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel", bar)
    title.Size = UDim2.new(1, -50, 1, 0)
    title.Position = UDim2.new(0, 14, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🔥 Hat Orbit v9.9.8"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 3
    
    local powerBtn = Instance.new("TextButton", bar)
    powerBtn.Size = UDim2.new(0, 34, 0, 24)
    powerBtn.Position = UDim2.new(1, -68, 0.5, -12)
    powerBtn.Text = "⏻"
    powerBtn.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
    powerBtn.TextColor3 = Color3.new(1, 1, 1)
    powerBtn.Font = Enum.Font.GothamBold
    powerBtn.TextSize = 16
    powerBtn.ZIndex = 3
    Instance.new("UICorner", powerBtn).CornerRadius = UDim.new(0, 5)
    
    local closeBtn = Instance.new("TextButton", bar)
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
    closeBtn.Text = "✕"
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 45, 45)
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 13
    closeBtn.ZIndex = 3
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
    closeBtn.MouseButton1Click:Connect(function()
        Core.isActive = false
        Core.removeAllHats()
        screenGui:Destroy()
    end)
    
    local scrollFrame = Instance.new("ScrollingFrame", main)
    scrollFrame.Position = UDim2.new(0, 0, 0, 34)
    scrollFrame.Size = UDim2.new(1, 0, 1, -34)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
    scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    scrollFrame.ZIndex = 2
    Instance.new("UICorner", scrollFrame).CornerRadius = UDim.new(0, 6)
    
    local content = Instance.new("Frame", scrollFrame)
    content.Size = UDim2.new(1, -8, 0, 0)
    content.BackgroundTransparency = 1
    content.ZIndex = 2
    
    local y = 10
    local PAD = 12
    
    -- ═══ GUI HELPER FUNCTIONS
    local function addModeRow(label, modes, getCur, onSel)
        local l = Instance.new("TextLabel", content)
        l.Size = UDim2.new(1, -PAD*2, 0, 14)
        l.Position = UDim2.new(0, PAD, 0, y)
        l.BackgroundTransparency = 1
        l.Text = label
        l.TextColor3 = Color3.fromRGB(190, 190, 200)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 11
        l.TextXAlignment = Enum.TextXAlignment.Left
        y = y + 16
        local r = Instance.new("Frame", content)
        r.Size = UDim2.new(1, -PAD*2, 0, 32)
        r.Position = UDim2.new(0, PAD, 0, y)
        r.BackgroundTransparency = 1
        local btns = {}
        local function rf() for k,b in pairs(btns) do b.BackgroundColor3 = (k==getCur()) and Color3.fromRGB(70,130,240) or Color3.fromRGB(40,40,48) end end
        local tg = (#modes-1)*4
        local bw = ((280-PAD*2)-tg)/#modes
        for i,m in ipairs(modes) do
            local b = Instance.new("TextButton", r)
            b.Size = UDim2.new(0, bw, 1, 0)
            b.Position = UDim2.new(0, (i-1)*(bw+4), 0, 0)
            b.Text = m.text
            b.Font = Enum.Font.GothamBold
            b.TextSize = 9
            b.TextColor3 = Color3.new(1,1,1)
            b.BackgroundColor3 = Color3.fromRGB(40,40,48)
            b.ZIndex = 3
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
            btns[m.key] = b
            b.MouseButton1Click:Connect(function() onSel(m.key); rf() end)
        end
        rf()
        y = y + 40
    end
    
    local function addSlider(label, minV, maxV, def, step, onCh)
        local r = Instance.new("Frame", content)
        r.Size = UDim2.new(1, -PAD*2, 0, 38)
        r.Position = UDim2.new(0, PAD, 0, y)
        r.BackgroundTransparency = 1
        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(1, -44, 0, 16)
        l.BackgroundTransparency = 1
        l.Text = label
        l.TextColor3 = Color3.fromRGB(190,190,200)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 11
        l.TextXAlignment = Enum.TextXAlignment.Left
        local vl = Instance.new("TextLabel", r)
        vl.Size = UDim2.new(0, 44, 0, 16)
        vl.Position = UDim2.new(1, -44, 0, 0)
        vl.BackgroundTransparency = 1
        vl.Text = tostring(def)
        vl.TextColor3 = Color3.fromRGB(140,200,255)
        vl.Font = Enum.Font.Code
        vl.TextSize = 11
        vl.TextXAlignment = Enum.TextXAlignment.Right
        local b = Instance.new("TextBox", r)
        b.Size = UDim2.new(1, -44, 0, 20)
        b.Position = UDim2.new(0, 0, 0, 16)
        b.BackgroundColor3 = Color3.fromRGB(40,40,48)
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.Code
        b.TextSize = 12
        b.Text = tostring(def)
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
        local mn = Instance.new("TextButton", r)
        mn.Size = UDim2.new(0, 18, 0, 18)
        mn.Position = UDim2.new(1, -44, 0, 18)
        mn.Text = "−"
        mn.BackgroundColor3 = Color3.fromRGB(55,55,65)
        mn.TextColor3 = Color3.new(1,1,1)
        mn.Font = Enum.Font.GothamBold
        mn.TextSize = 12
        mn.ZIndex = 5
        Instance.new("UICorner", mn).CornerRadius = UDim.new(0,4)
        local pl = Instance.new("TextButton", r)
        pl.Size = UDim2.new(0, 18, 0, 18)
        pl.Position = UDim2.new(1, -22, 0, 18)
        pl.Text = "+"
        pl.BackgroundColor3 = Color3.fromRGB(55,55,65)
        pl.TextColor3 = Color3.new(1,1,1)
        pl.Font = Enum.Font.GothamBold
        pl.TextSize = 12
        pl.ZIndex = 5
        Instance.new("UICorner", pl).CornerRadius = UDim.new(0,4)
        local function ap(v)
            v = math.clamp(tonumber(v) or def, minV, maxV)
            local rd = math.floor(v*100+0.5)/100
            b.Text = tostring(rd)
            vl.Text = tostring(rd)
            onCh(rd)
        end
        mn.MouseButton1Click:Connect(function() ap((tonumber(b.Text) or def)-step) end)
        pl.MouseButton1Click:Connect(function() ap((tonumber(b.Text) or def)+step) end)
        b.FocusLost:Connect(function() ap(b.Text) end)
        y = y + 42
    end
    
    local function addTog(label, getSt, onTog, onCl, offCl)
        local r = Instance.new("Frame", content)
        r.Size = UDim2.new(1, -PAD*2, 0, 30)
        r.Position = UDim2.new(0, PAD, 0, y)
        r.BackgroundTransparency = 1
        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(0, 170, 1, 0)
        l.BackgroundTransparency = 1
        l.Text = label
        l.TextColor3 = Color3.fromRGB(190,190,200)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 11
        l.TextXAlignment = Enum.TextXAlignment.Left
        local b = Instance.new("TextButton", r)
        b.Size = UDim2.new(0, 70, 1, 0)
        b.Position = UDim2.new(1, -70, 0, 0)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.TextColor3 = Color3.new(1,1,1)
        b.ZIndex = 3
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
        local function rf()
            if getSt() then b.Text = onCl.text; b.BackgroundColor3 = onCl.bg
            else b.Text = offCl.text; b.BackgroundColor3 = offCl.bg end
        end
        rf()
        b.MouseButton1Click:Connect(function() onTog(); rf() end)
        y = y + 38
    end
    
    local function addSec(txt)
        local l = Instance.new("TextLabel", content)
        l.Size = UDim2.new(1, -PAD*2, 0, 16)
        l.Position = UDim2.new(0, PAD, 0, y)
        l.BackgroundTransparency = 1
        l.Text = txt
        l.TextColor3 = Color3.fromRGB(130,130,150)
        l.Font = Enum.Font.GothamBold
        l.TextSize = 10
        l.TextXAlignment = Enum.TextXAlignment.Center
        y = y + 20
    end
    
    local function updPwr()
        if Core.isActive then powerBtn.BackgroundColor3 = Color3.fromRGB(60,200,60); powerBtn.Text = "⏻"
        else powerBtn.BackgroundColor3 = Color3.fromRGB(200,60,60); powerBtn.Text = "⏸" end
    end
    
    powerBtn.MouseButton1Click:Connect(function()
        Core.isActive = not Core.isActive
        if Core.isActive then task.spawn(function() task.wait(0.1); Core.captureAllowedHats() end) else Core.removeAllHats() end
        updPwr()
    end)
    
    -- ═══════════════════════════════════════════════════════
    -- GUI SECTIONS - ALL FEATURES
    -- ═══════════════════════════════════════════════════════
    
    addModeRow("🔀 Orbit Axis", {{key="Y",text="Y Halo"},{key="X",text="X Tumble"},{key="Z",text="Z Fan"}}, function() return Core.ORBIT_MODE end, function(k) Core.ORBIT_MODE=k end)
    addModeRow("💫 Spin Axis", {{key="Y",text="Y"},{key="X",text="X"},{key="Z",text="Z"}}, function() return Core.SPIN_MODE end, function(k) Core.SPIN_MODE=k end)
    
    addSec("── Display ──")
    addSlider("🔍 GUI Scale", 0.5, 2.0, Core.GUI_SCALE, 0.05, function(v) Core.GUI_SCALE=v; uiScale.Scale=v end)
    
    addSec("── Gift Mode ──")
    addTog("🔘 Gift Mode", function() return Core.GIFT_ENABLED end, function() Core.GIFT_ENABLED=not Core.GIFT_ENABLED end, {text="🎁 ON",bg=Color3.fromRGB(60,150,220)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    do
        local r = Instance.new("Frame", content)
        r.Size = UDim2.new(1, -PAD*2, 0, 30)
        r.Position = UDim2.new(0, PAD, 0, y)
        r.BackgroundTransparency = 1
        local l = Instance.new("TextLabel", r)
        l.Size = UDim2.new(0, 90, 1, 0)
        l.BackgroundTransparency = 1
        l.Text = "🎯 Target"
        l.TextColor3 = Color3.fromRGB(190,190,200)
        l.Font = Enum.Font.GothamMedium
        l.TextSize = 11
        l.TextXAlignment = Enum.TextXAlignment.Left
        local b = Instance.new("TextButton", r)
        b.Size = UDim2.new(0, 150, 1, 0)
        b.Position = UDim2.new(1, -150, 0, 0)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.TextColor3 = Color3.new(1,1,1)
        b.BackgroundColor3 = Color3.fromRGB(70,70,85)
        b.ZIndex = 3
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
        local function rf() b.Text = (Core.GIFT_TARGET_NAME=="") and "🙋 Myself (tap ▸)" or ("🎯 "..Core.GIFT_TARGET_NAME.." (tap ▸)") end
        rf()
        b.MouseButton1Click:Connect(function()
            local n = {""}
            for _,p in ipairs(Players:GetPlayers()) do if p~=plr then table.insert(n,p.Name) end end
            local ci = 1
            for i,v in ipairs(n) do if v==Core.GIFT_TARGET_NAME then ci=i break end end
            Core.GIFT_TARGET_NAME = n[(ci%#n)+1]
            rf()
        end)
        y = y + 38
    end
    
    -- OUTER RING 1
    addSec("── Outer Ring 1 ──")
    addSlider("📏 Distance", -10000,10000, Core.DISTANCE, 0.5, function(v) Core.DISTANCE=v end)
    addSlider("⭕ Radius", -10000,10000, Core.ORBIT_RADIUS, 0.5, function(v) Core.ORBIT_RADIUS=v end)
    addSlider("🌀 Speed", -10000,10000, Core.ORBIT_SPEED, 5, function(v) Core.ORBIT_SPEED=v end)
    addSlider("↕️ Height", -10000,10000, Core.HEIGHT_OFFSET, 0.5, function(v) Core.HEIGHT_OFFSET=v end)
    addSlider("💫 Spin", -10000,10000, Core.SPIN_SPEED, 0.5, function(v) Core.SPIN_SPEED=v end)
    addModeRow("🔀 Axis", {{key="Y",text="Y Halo"},{key="X",text="X Tumble"},{key="Z",text="Z Fan"}}, function() return Core.ORBIT_MODE end, function(k) Core.ORBIT_MODE=k end)
    addTog("🔀 Split", function() return Core.USE_SPLIT end, function() Core.USE_SPLIT=not Core.USE_SPLIT end, {text="🔀 ON",bg=Color3.fromRGB(255,170,0)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("📊 Split Ratio", 0.1,0.9, Core.SPLIT_RATIO, 0.05, function(v) Core.SPLIT_RATIO=v end)
    addTog("☀️ Shoot Out", function() return Core.USE_SHOOT_OUT end, function() Core.USE_SHOOT_OUT=not Core.USE_SHOOT_OUT end, {text="☀️ ON",bg=Color3.fromRGB(255,200,0)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("☀️ Range", -10000,10000, Core.SHOOT_OUT_RANGE, 0.5, function(v) Core.SHOOT_OUT_RANGE=v end)
    addSlider("🚀 Pulse Speed", -10000,10000, Core.SHOOT_OUT_SPEED, 10, function(v) Core.SHOOT_OUT_SPEED=v end)
    addSlider("🌀 Orbit Speed", -10000,10000, Core.SHOOT_OUT_ORBIT_SPEED, 10, function(v) Core.SHOOT_OUT_ORBIT_SPEED=v end)
    addTog("🌍 Orbit While Shoot", function() return Core.USE_SHOOT_OUT_ORBIT end, function() Core.USE_SHOOT_OUT_ORBIT=not Core.USE_SHOOT_OUT_ORBIT end, {text="🌍 ON",bg=Color3.fromRGB(0,150,100)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    
    -- OUTER RING 2 (with Wing Mode)
    addSec("── Outer Ring 2 ──")
    addTog("🔘 Outer Ring 2", function() return Core.USE_OUTER2 end, function() Core.USE_OUTER2=not Core.USE_OUTER2 end, {text="🔵 ON",bg=Color3.fromRGB(60,150,220)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("👤 Count", 1,16, Core.OUTER2_COUNT, 1, function(v) Core.OUTER2_COUNT=math.floor(v) end)
    addModeRow("🔀 Axis", {{key="Y",text="Y Halo"},{key="X",text="X Tumble"},{key="Z",text="Z Fan"}}, function() return Core.OUTER2_MODE end, function(k) Core.OUTER2_MODE=k end)
    addSlider("📏 Distance", -10000,10000, Core.OUTER2_DISTANCE, 0.5, function(v) Core.OUTER2_DISTANCE=v end)
    addSlider("⭕ Radius", -10000,10000, Core.OUTER2_RADIUS, 0.5, function(v) Core.OUTER2_RADIUS=v end)
    addSlider("🌀 Speed", -10000,10000, Core.OUTER2_SPEED, 5, function(v) Core.OUTER2_SPEED=v end)
    addSlider("↕️ Height", -10000,10000, Core.OUTER2_HEIGHT, 0.5, function(v) Core.OUTER2_HEIGHT=v end)
    addSlider("💫 Spin", -10000,10000, Core.OUTER2_SPIN, 0.5, function(v) Core.OUTER2_SPIN=v end)
    addTog("🔀 Split", function() return Core.USE_OUTER2_SPLIT end, function() Core.USE_OUTER2_SPLIT=not Core.USE_OUTER2_SPLIT end, {text="🔀 ON",bg=Color3.fromRGB(255,170,0)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("📊 Split Ratio", 0.1,0.9, Core.OUTER2_SPLIT_RATIO, 0.05, function(v) Core.OUTER2_SPLIT_RATIO=v end)
    
    -- WING MODE (3-AXIS)
    addSec("── 🕊️ Wing Mode (3-Axis) ──")
    addTog("🔘 Wing Mode", function() return Core.USE_WING end, function() Core.USE_WING=not Core.USE_WING end, {text="🕊️ ON",bg=Color3.fromRGB(100,200,255)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    
    addSec("  X-Axis (Roll)")
    addSlider("Min X-Axis", -180,180, Core.WING_MIN_X, 1, function(v) Core.WING_MIN_X=math.floor(v) end)
    addSlider("Max X-Axis", -180,180, Core.WING_MAX_X, 1, function(v) Core.WING_MAX_X=math.floor(v) end)
    addSlider("X Speed", 1,180, Core.WING_SPEED_X, 1, function(v) Core.WING_SPEED_X=v end)
    
    addSec("  Y-Axis (Pitch)")
    addSlider("Min Y-Axis", -180,180, Core.WING_MIN_Y, 1, function(v) Core.WING_MIN_Y=math.floor(v) end)
    addSlider("Max Y-Axis", -180,180, Core.WING_MAX_Y, 1, function(v) Core.WING_MAX_Y=math.floor(v) end)
    addSlider("Y Speed", 1,180, Core.WING_SPEED_Y, 1, function(v) Core.WING_SPEED_Y=v end)
    
    addSec("  Z-Axis (Yaw)")
    addSlider("Min Z-Axis", -180,180, Core.WING_MIN_Z, 1, function(v) Core.WING_MIN_Z=math.floor(v) end)
    addSlider("Max Z-Axis", -180,180, Core.WING_MAX_Z, 1, function(v) Core.WING_MAX_Z=math.floor(v) end)
    addSlider("Z Speed", 1,180, Core.WING_SPEED_Z, 1, function(v) Core.WING_SPEED_Z=v end)
    
    -- OUTER RING 3
    addSec("── Outer Ring 3 ──")
    addTog("🔘 Outer Ring 3", function() return Core.USE_OUTER3 end, function() Core.USE_OUTER3=not Core.USE_OUTER3 end, {text="🔵 ON",bg=Color3.fromRGB(60,150,220)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("👤 Count", 1,16, Core.OUTER3_COUNT, 1, function(v) Core.OUTER3_COUNT=math.floor(v) end)
    addModeRow("🔀 Axis", {{key="Y",text="Y Halo"},{key="X",text="X Tumble"},{key="Z",text="Z Fan"}}, function() return Core.OUTER3_MODE end, function(k) Core.OUTER3_MODE=k end)
    addSlider("📏 Distance", -10000,10000, Core.OUTER3_DISTANCE, 0.5, function(v) Core.OUTER3_DISTANCE=v end)
    addSlider("⭕ Radius", -10000,10000, Core.OUTER3_RADIUS, 0.5, function(v) Core.OUTER3_RADIUS=v end)
    addSlider("🌀 Speed", -10000,10000, Core.OUTER3_SPEED, 5, function(v) Core.OUTER3_SPEED=v end)
    addSlider("↕️ Height", -10000,10000, Core.OUTER3_HEIGHT, 0.5, function(v) Core.OUTER3_HEIGHT=v end)
    addSlider("💫 Spin", -10000,10000, Core.OUTER3_SPIN, 0.5, function(v) Core.OUTER3_SPIN=v end)
    addTog("🔀 Split", function() return Core.USE_OUTER3_SPLIT end, function() Core.USE_OUTER3_SPLIT=not Core.USE_OUTER3_SPLIT end, {text="🔀 ON",bg=Color3.fromRGB(255,170,0)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("📊 Split Ratio", 0.1,0.9, Core.OUTER3_SPLIT_RATIO, 0.05, function(v) Core.OUTER3_SPLIT_RATIO=v end)
    
    -- OUTER RING 4
    addSec("── Outer Ring 4 ──")
    addTog("🔘 Outer Ring 4", function() return Core.USE_OUTER4 end, function() Core.USE_OUTER4=not Core.USE_OUTER4 end, {text="🔵 ON",bg=Color3.fromRGB(60,150,220)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("👤 Count", 1,16, Core.OUTER4_COUNT, 1, function(v) Core.OUTER4_COUNT=math.floor(v) end)
    addModeRow("🔀 Axis", {{key="Y",text="Y Halo"},{key="X",text="X Tumble"},{key="Z",text="Z Fan"}}, function() return Core.OUTER4_MODE end, function(k) Core.OUTER4_MODE=k end)
    addSlider("📏 Distance", -10000,10000, Core.OUTER4_DISTANCE, 0.5, function(v) Core.OUTER4_DISTANCE=v end)
    addSlider("⭕ Radius", -10000,10000, Core.OUTER4_RADIUS, 0.5, function(v) Core.OUTER4_RADIUS=v end)
    addSlider("🌀 Speed", -10000,10000, Core.OUTER4_SPEED, 5, function(v) Core.OUTER4_SPEED=v end)
    addSlider("↕️ Height", -10000,10000, Core.OUTER4_HEIGHT, 0.5, function(v) Core.OUTER4_HEIGHT=v end)
    addSlider("💫 Spin", -10000,10000, Core.OUTER4_SPIN, 0.5, function(v) Core.OUTER4_SPIN=v end)
    addTog("🔀 Split", function() return Core.USE_OUTER4_SPLIT end, function() Core.USE_OUTER4_SPLIT=not Core.USE_OUTER4_SPLIT end, {text="🔀 ON",bg=Color3.fromRGB(255,170,0)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("📊 Split Ratio", 0.1,0.9, Core.OUTER4_SPLIT_RATIO, 0.05, function(v) Core.OUTER4_SPLIT_RATIO=v end)
    
    -- INNER RING
    addSec("── Inner Ring ──")
    addTog("🔘 Inner Ring", function() return Core.USE_INNER_RING end, function() Core.USE_INNER_RING=not Core.USE_INNER_RING end, {text="🔵 ON",bg=Color3.fromRGB(60,150,220)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("👤 Count", 1,12, Core.INNER_COUNT, 1, function(v) Core.INNER_COUNT=math.floor(v) end)
    addModeRow("⚡ Mode", {{key="Ring",text="💍 Ring"},{key="Lazer",text="🔴 Lazer"},{key="DoubleLazer",text="🔴🔴 Double"},{key="Fireball",text="🔥 Fireball"},{key="DoubleStar",text="🌌 Dual"}}, function() return Core.INNER_MODE end, function(k) Core.INNER_MODE=k end)
    addModeRow("🔀 Axis", {{key="Y",text="Y Halo"},{key="X",text="X Tumble"},{key="Z",text="Z Fan"}}, function() return Core.INNER_ORBIT_MODE end, function(k) Core.INNER_ORBIT_MODE=k end)
    
    addSec("── Inner Props ──")
    addSlider("📏 Distance", -10000,10000, Core.INNER_DISTANCE, 0.5, function(v) Core.INNER_DISTANCE=v end)
    addSlider("⭕ Radius", -10000,10000, Core.INNER_ORBIT_RADIUS, 0.5, function(v) Core.INNER_ORBIT_RADIUS=v end)
    addSlider("🌀 Speed", -10000,10000, Core.INNER_ORBIT_SPEED, 5, function(v) Core.INNER_ORBIT_SPEED=v end)
    addSlider("↕︁ Height", -10000,10000, Core.INNER_HEIGHT_OFFSET, 0.5, function(v) Core.INNER_HEIGHT_OFFSET=v end)
    addSlider("💫 Spin", -10000,10000, Core.INNER_SPIN_SPEED, 0.5, function(v) Core.INNER_SPIN_SPEED=v end)
    
    addSec("── Double Lazer Props ──")
    addSlider("📏 Distance", -10000,10000, Core.INNER_LAZER_DISTANCE, 0.5, function(v) Core.INNER_LAZER_DISTANCE=v end)
    addSlider("↕︁ Height", -10000,10000, Core.INNER_LAZER_HEIGHT, 0.5, function(v) Core.INNER_LAZER_HEIGHT=v end)
    addSlider("📐 Range", -10000,10000, Core.INNER_LAZER_RANGE, 0.5, function(v) Core.INNER_LAZER_RANGE=v end)
    addSlider("🚀 Shoot Speed", -10000,10000, Core.INNER_LAZER_SPEED, 10, function(v) Core.INNER_LAZER_SPEED=v end)
    addSlider("🌀 Orbit Speed", -10000,10000, Core.INNER_LAZER_ORBIT_SPEED, 10, function(v) Core.INNER_LAZER_ORBIT_SPEED=v end)
    addSlider("⭕ Beam Radius", -1000,1000, Core.INNER_LAZER_RADIUS, 0.2, function(v) Core.INNER_LAZER_RADIUS=v end)
    addSlider("↔️ Beam Gap", -1000,1000, Core.INNER_BEAM_GAP, 0.2, function(v) Core.INNER_BEAM_GAP=v end)
    
    addSec("── Fireball Props ──")
    addSlider("🌀 Orbit Speed Z", -10000,10000, Core.FB_ORBIT_SPEED, 5, function(v) Core.FB_ORBIT_SPEED=v end)
    addSlider("🔄 Y 360° Spin", -10000,10000, Core.FB_Y_SPIN_SPEED, 5, function(v) Core.FB_Y_SPIN_SPEED=v end)
    addSlider("📏 Distance", -10000,10000, Core.FB_DISTANCE, 0.5, function(v) Core.FB_DISTANCE=v end)
    addSlider("↕︁ Height", -10000,10000, Core.FB_HEIGHT, 0.5, function(v) Core.FB_HEIGHT=v end)
    addSlider("⭕ Sphere Size", -10000,10000, Core.FB_SIZE, 0.5, function(v) Core.FB_SIZE=v end)
    addSlider("📐 Range", -10000,10000, Core.FB_RANGE, 0.5, function(v) Core.FB_RANGE=v end)
    addSlider("🚀 Pulse Speed", -10000,10000, Core.FB_SHOOT_SPEED, 10, function(v) Core.FB_SHOOT_SPEED=v end)
    
    addSec("── Double Star Props ──")
    addSlider("🌀 Orbit Speed Z", -10000,10000, Core.DS_ORBIT_SPEED, 5, function(v) Core.DS_ORBIT_SPEED=v end)
    addSlider("🔄 Y 360° Spin", -10000,10000, Core.DS_Y_SPIN_SPEED, 5, function(v) Core.DS_Y_SPIN_SPEED=v end)
    addSlider("📏 Distance", -10000,10000, Core.DS_DISTANCE, 0.5, function(v) Core.DS_DISTANCE=v end)
    addSlider("↕︁ Height", -10000,10000, Core.DS_HEIGHT, 0.5, function(v) Core.DS_HEIGHT=v end)
    addSlider("⭕ Sphere Size", -10000,10000, Core.DS_SIZE, 0.5, function(v) Core.DS_SIZE=v end)
    addSlider("🌌 Centre Orbit Speed", -10000,10000, Core.DS_CENTER_SPEED, 5, function(v) Core.DS_CENTER_SPEED=v end)
    addSlider("🪐 Centre Orbit Size", -10000,10000, Core.DS_CENTER_RADIUS, 0.5, function(v) Core.DS_CENTER_RADIUS=v end)
    
    -- HOLD MODES
    addSec("── Shield ──")
    addTog("🔘 Shield", function() return Core.USE_SHIELD end, function() Core.setShieldEnabled(not Core.USE_SHIELD) end, {text="🛡️ ON",bg=Color3.fromRGB(60,150,220)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("👈 Left Hat", 1,21, Core.SHIELD_LEFT_INDEX, 1, function(v) Core.SHIELD_LEFT_INDEX=math.floor(v) end)
    addSlider("👉 Right Hat", 1,21, Core.SHIELD_RIGHT_INDEX, 1, function(v) Core.SHIELD_RIGHT_INDEX=math.floor(v) end)
    addSlider("📏 Distance", -10000,10000, Core.SHIELD_DISTANCE, 0.5, function(v) Core.SHIELD_DISTANCE=v end)
    addSlider("⭕ Radius", -10000,10000, Core.SHIELD_RADIUS, 0.5, function(v) Core.SHIELD_RADIUS=v end)
    addSlider("🌀 Speed", -10000,10000, Core.SHIELD_SPEED, 5, function(v) Core.SHIELD_SPEED=v end)
    addSlider("↕︁ Height", -10000,10000, Core.SHIELD_HEIGHT, 0.5, function(v) Core.SHIELD_HEIGHT=v end)
    
    addSec("── Double Lazer HOLD ──")
    addTog("🔘 Double Lazer", function() return Core.USE_DLAZER_HOLD end, function() Core.setDLazerHoldEnabled(not Core.USE_DLAZER_HOLD) end, {text="⚡ ON",bg=Color3.fromRGB(255,100,0)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("👈 Left Hat", 1,21, Core.DLAZER_LEFT_INDEX, 1, function(v) Core.DLAZER_LEFT_INDEX=math.floor(v) end)
    addSlider("👉 Right Hat", 1,21, Core.DLAZER_RIGHT_INDEX, 1, function(v) Core.DLAZER_RIGHT_INDEX=math.floor(v) end)
    addSlider("📏 Distance", -10000,10000, Core.DLAZER_DISTANCE, 0.5, function(v) Core.DLAZER_DISTANCE=v end)
    addSlider("↕︁ Height", -10000,10000, Core.DLAZER_HEIGHT, 0.5, function(v) Core.DLAZER_HEIGHT=v end)
    addSlider("📐 Range", -10000,10000, Core.DLAZER_RANGE, 0.5, function(v) Core.DLAZER_RANGE=v end)
    addSlider("🚀 Shoot Speed", -10000,10000, Core.DLAZER_SHOOT_SPEED, 10, function(v) Core.DLAZER_SHOOT_SPEED=v end)
    addSlider("⭕ Beam Radius", -1000,1000, Core.DLAZER_BEAM_RADIUS, 0.2, function(v) Core.DLAZER_BEAM_RADIUS=v end)
    addSlider("🌀 Orbit Speed", -10000,10000, Core.DLAZER_ORBIT_SPEED, 10, function(v) Core.DLAZER_ORBIT_SPEED=v end)
    addSlider("◀︁ Left Offset", -10000,10000, Core.DLAZER_LEFT_OFFSET, 0.1, function(v) Core.DLAZER_LEFT_OFFSET=v end)
    addSlider("▶︁ Right Offset", -10000,10000, Core.DLAZER_RIGHT_OFFSET, 0.1, function(v) Core.DLAZER_RIGHT_OFFSET=v end)
    addSlider("🔄 Rot X", -180,180, Core.DLAZER_ROT_X, 5, function(v) Core.DLAZER_ROT_X=v end)
    addSlider("🔄 Rot Y", -180,180, Core.DLAZER_ROT_Y, 5, function(v) Core.DLAZER_ROT_Y=v end)
    addSlider("🔄 Rot Z", -180,180, Core.DLAZER_ROT_Z, 5, function(v) Core.DLAZER_ROT_Z=v end)
    
    addSec("── Fireball HOLD ──")
    addTog("🔘 Fireball HOLD", function() return Core.USE_FIREBALL_HOLD end, function() Core.setFireballHoldEnabled(not Core.USE_FIREBALL_HOLD) end, {text="🔥 ON",bg=Color3.fromRGB(255,120,0)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
    addSlider("👈 Left Hat", 1,21, Core.FIREBALL_LEFT_INDEX, 1, function(v) Core.FIREBALL_LEFT_INDEX=math.floor(v) end)
    addSlider("👉 Right Hat", 1,21, Core.FIREBALL_RIGHT_INDEX, 1, function(v) Core.FIREBALL_RIGHT_INDEX=math.floor(v) end)
    addSlider("📏 Distance", -10000,10000, Core.FIREBALL_DISTANCE, 0.5, function(v) Core.FIREBALL_DISTANCE=v end)
    addSlider("↕︁ Height", -10000,10000, Core.FIREBALL_HEIGHT, 0.5, function(v) Core.FIREBALL_HEIGHT=v end)
    addSlider("⭕ Sphere Size", -10000,10000, Core.FIREBALL_SPHERE_SIZE, 0.5, function(v) Core.FIREBALL_SPHERE_SIZE=v end)
    addSlider("📐 Range", -10000,10000, Core.FIREBALL_RANGE, 0.5, function(v) Core.FIREBALL_RANGE=v end)
    addSlider("🚀 Pulse Speed", -10000,10000, Core.FIREBALL_SHOOT_SPEED, 10, function(v) Core.FIREBALL_SHOOT_SPEED=v end)
    addSlider("🌀 Orbit Speed Z", -10000,10000, Core.FIREBALL_ORBIT_SPEED, 5, function(v) Core.FIREBALL_ORBIT_SPEED=v end)
    addSlider("🔄 Y 360° Spin", -10000,10000, Core.FIREBALL_Y_SPIN_SPEED, 5, function(v) Core.FIREBALL_Y_SPIN_SPEED=v end)
    addSlider("◀︁ Left Offset", -10000,10000, Core.FIREBALL_LEFT_OFFSET, 0.1, function(v) Core.FIREBALL_LEFT_OFFSET=v end)
    addSlider("▶︁ Right Offset", -10000,10000, Core.FIREBALL_RIGHT_OFFSET, 0.1, function(v) Core.FIREBALL_RIGHT_OFFSET=v end)
    addSlider("🔄 Rot X", -180,180, Core.FIREBALL_ROT_X, 5, function(v) Core.FIREBALL_ROT_X=v end)
    addSlider("🔄 Rot Y", -180,180, Core.FIREBALL_ROT_Y, 5, function(v) Core.FIREBALL_ROT_Y=v end)
    addSlider("🔄 Rot Z", -180,180, Core.FIREBALL_ROT_Z, 5, function(v) Core.FIREBALL_ROT_Z=v end)
    
    -- 10 HOLD SLOTS
    addSec("── Hold Slots ──")
    local holdNames = {"Hold Mode","Hold Control 1","Hold Control 2","Hold Control 3","Hold Control 4","Hold Control 5","Hold Control 6","Hold Control 7","Hold Control 8","Hold Control 9"}
    for i=1,10 do
        local slot = Core.HOLD_SLOTS[i]
        addSec("── "..holdNames[i].." (Slot "..i..") ──")
        addTog("🔘 "..holdNames[i], function() return slot.USE end, function() Core.setHoldSlotEnabled(i,not slot.USE) end, {text="✋ ON",bg=Color3.fromRGB(60,150,220)}, {text="⚫ OFF",bg=Color3.fromRGB(55,55,65)})
        addSlider("👈 Left Hat", 1,21, slot.LIDX, 1, function(v) slot.LIDX=math.floor(v) end)
        addSlider("👉 Right Hat", 1,21, slot.RIDX, 1, function(v) slot.RIDX=math.floor(v) end)
        addSlider("📏 Distance", -10000,10000, slot.DIST, 0.5, function(v) slot.DIST=v end)
        addSlider("↕︁ Height", -10000,10000, slot.HGT, 0.5, function(v) slot.HGT=v end)
        addSlider("◀︁ Left Offset", -10000,10000, slot.LOFF, 0.1, function(v) slot.LOFF=v end)
        addSlider("▶︁ Right Offset", -10000,10000, slot.ROFF, 0.1, function(v) slot.ROFF=v end)
        addSlider("🔄 Rot X", -180,180, slot.RX, 5, function(v) slot.RX=v end)
        addSlider("🔄 Rot Y", -180,180, slot.RY, 5, function(v) slot.RY=v end)
        addSlider("🔄 Rot Z", -180,180, slot.RZ, 5, function(v) slot.RZ=v end)
    end
    
    -- GENERAL
    addSec("── General ──")
    addSlider("📊 Max Hats", 1,30, Core.MAX_HATS, 1, function(v) Core.MAX_HATS=math.floor(v) end)
    addSlider("🌊 Smoothness", 0.1,20, Core.SMOOTHNESS, 0.1, function(v) Core.SMOOTHNESS=v end)
    addTog("🧲 Magnet", function() return Core.MAGNET_ENABLED end, function() Core.MAGNET_ENABLED=not Core.MAGNET_ENABLED; Core.setMagnetEnabled(Core.MAGNET_ENABLED) end, {text="🧲 ON",bg=Color3.fromRGB(60,180,80)}, {text="⛔ OFF",bg=Color3.fromRGB(180,55,55)})
    
    -- BUTTONS
    local function mkBtn(txt, bg, cb)
        local b = Instance.new("TextButton", content)
        b.Size = UDim2.new(1, -PAD*2, 0, 34)
        b.Position = UDim2.new(0, PAD, 0, y)
        b.Text = txt
        b.BackgroundColor3 = bg
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 12
        b.ZIndex = 3
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,7)
        b.MouseButton1Click:Connect(cb)
        y = y + 38
        return b
    end
    
    local capBtn = mkBtn("🎩 Capture All Hats", Color3.fromRGB(70,130,240), function()
        Core.captureAllowedHats()
        capBtn.BackgroundColor3 = Color3.fromRGB(50,190,70)
        capBtn.Text = "✅ Captured!"
        task.delay(0.8, function()
            if capBtn and capBtn.Parent then
                capBtn.BackgroundColor3 = Color3.fromRGB(70,130,240)
                capBtn.Text = "🎩 Capture All Hats"
            end
        end)
    end)
    mkBtn("🗑️ Remove All", Color3.fromRGB(200,55,55), function()
        Core.removeAllHats()
        if capBtn and capBtn.Parent then capBtn.Text = "🎩 Capture All Hats" end
    end)
    mkBtn("👁️ Toggle GUI [RightShift]", Color3.fromRGB(55,55,65), function()
        main.Visible = not main.Visible
    end)
    
    content.Size = UDim2.new(1, -8, 0, y + 10)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, y + 10)
    
    UserInputService.InputBegan:Connect(function(i, g)
        if not g and i.KeyCode == Enum.KeyCode.RightShift then
            main.Visible = not main.Visible
        end
    end)
    
    print("✅ GUI Created with all features")
end

return GUI
