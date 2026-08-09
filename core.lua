-- core.lua
local Core = {}

-- Services (lazy)
local function getPlayers() return game:GetService("Players") end
local function getRunService() return game:GetService("RunService") end
local function getUserInputService() return game:GetService("UserInputService") end

local function getPlayer()
    if not Core._player then
        Core._player = getPlayers().LocalPlayer
        while not Core._player do task.wait(); Core._player = getPlayers().LocalPlayer end
    end
    return Core._player
end

local function getCharacter()
    local plr = getPlayer()
    return plr.Character or plr.CharacterAdded:Wait()
end

local function getHRP()
    local chr = getCharacter()
    return chr:WaitForChild("HumanoidRootPart")
end

-- ═══════════════════════════════════════════════════════
-- SETTINGS
-- ═══════════════════════════════════════════════════════
Core.DISTANCE = 5
Core.ORBIT_RADIUS = 3
Core.ORBIT_SPEED = 60
Core.ORBIT_MODE = "Y"
Core.HEIGHT_OFFSET = 2
Core.SPIN_SPEED = 1
Core.ORBIT_ROTATION = 0

Core.USE_OUTER2 = false
Core.OUTER2_COUNT = 4
Core.OUTER2_MODE = "X"
Core.OUTER2_DISTANCE = 5
Core.OUTER2_RADIUS = 3
Core.OUTER2_SPEED = 60
Core.OUTER2_HEIGHT = 2
Core.OUTER2_SPIN = 1
Core.OUTER2_ROTATION = 0
Core.OUTER2_SPIN_MODE = "Y"  -- NEW

Core.USE_OUTER3 = false
Core.OUTER3_COUNT = 4
Core.OUTER3_MODE = "Y"
Core.OUTER3_DISTANCE = 5
Core.OUTER3_RADIUS = 4
Core.OUTER3_SPEED = 60
Core.OUTER3_HEIGHT = 2
Core.OUTER3_SPIN = 1
Core.OUTER3_ROTATION = 0

Core.USE_OUTER4 = false
Core.OUTER4_COUNT = 4
Core.OUTER4_MODE = "Z"
Core.OUTER4_DISTANCE = 6
Core.OUTER4_RADIUS = 5
Core.OUTER4_SPEED = 45
Core.OUTER4_HEIGHT = 3
Core.OUTER4_SPIN = 1
Core.OUTER4_ROTATION = 0

Core.USE_SHOOT_OUT = false
Core.SHOOT_OUT_RANGE = 15
Core.SHOOT_OUT_SPEED = 120
Core.SHOOT_OUT_ORBIT_SPEED = 60
Core.USE_SHOOT_OUT_ORBIT = true

Core.USE_INNER_RING = true
Core.INNER_COUNT = 4
Core.INNER_MODE = "DoubleLazer"
Core.INNER_ORBIT_MODE = "Y"
Core.INNER_DISTANCE = 2
Core.INNER_ORBIT_RADIUS = 1.5
Core.INNER_ORBIT_SPEED = 120
Core.INNER_HEIGHT_OFFSET = 2
Core.INNER_SPIN_SPEED = 2
Core.INNER_LAZER_DISTANCE = 3
Core.INNER_LAZER_HEIGHT = 2
Core.INNER_LAZER_RANGE = 5
Core.INNER_LAZER_SPEED = 180
Core.INNER_LAZER_RADIUS = 1.2
Core.INNER_LAZER_ORBIT_SPEED = 400
Core.INNER_BEAM_GAP = 2

Core.FB_ORBIT_SPEED = 150
Core.FB_Y_SPIN_SPEED = 100
Core.FB_DISTANCE = 2.5
Core.FB_HEIGHT = 1.5
Core.FB_SIZE = 3.5
Core.FB_RANGE = 5
Core.FB_SHOOT_SPEED = 200

Core.DS_ORBIT_SPEED = 150
Core.DS_Y_SPIN_SPEED = 100
Core.DS_DISTANCE = 3
Core.DS_HEIGHT = 2
Core.DS_SIZE = 2.5
Core.DS_CENTER_SPEED = 60
Core.DS_CENTER_RADIUS = 3

Core.USE_SHIELD = false
Core.SHIELD_DISTANCE = 3
Core.SHIELD_RADIUS = 2.5
Core.SHIELD_SPEED = 90
Core.SHIELD_HEIGHT = 1
Core.SHIELD_LEFT_INDEX = 1
Core.SHIELD_RIGHT_INDEX = 2

Core.SPIN_MODE = "Y"
Core.MAGNET_ENABLED = true
Core.SMOOTHNESS = 12
Core.MAX_HATS = 22
Core.GUI_SCALE = 1.0

Core.GIFT_ENABLED = false
Core.GIFT_TARGET_NAME = ""
Core.isActive = true

Core.USE_SPLIT = false
Core.SPLIT_RATIO = 0.5
Core.USE_OUTER2_SPLIT = false
Core.OUTER2_SPLIT_RATIO = 0.5
Core.USE_OUTER3_SPLIT = false
Core.OUTER3_SPLIT_RATIO = 0.5
Core.USE_OUTER4_SPLIT = false
Core.OUTER4_SPLIT_RATIO = 0.5

Core.HOLD_SLOTS = {
    {USE=false, DIST=-4, HGT=0, LOFF=0.7, ROFF=0.7, RX=-50, RY=140, RZ=0, LIDX=1, RIDX=2},
    {USE=false, DIST=-10.5, HGT=0, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=3, RIDX=4},
    {USE=false, DIST=-20.5, HGT=1, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=5, RIDX=6},
    {USE=false, DIST=-30.5, HGT=1, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=7, RIDX=8},
    {USE=false, DIST=-40.5, HGT=2, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=9, RIDX=10},
    {USE=false, DIST=-50.5, HGT=3, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=11, RIDX=12},
    {USE=false, DIST=-60.5, HGT=4, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=13, RIDX=14},
    {USE=false, DIST=-70.5, HGT=5, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=15, RIDX=16},
    {USE=false, DIST=-80.5, HGT=6, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=17, RIDX=18},
    {USE=false, DIST=-90.5, HGT=7, LOFF=0.7, ROFF=0.7, RX=140, RY=0, RZ=0, LIDX=19, RIDX=20},
}

Core.USE_DLAZER_HOLD = false
Core.DLAZER_LEFT_INDEX = 1
Core.DLAZER_RIGHT_INDEX = 2
Core.DLAZER_DISTANCE = 10
Core.DLAZER_HEIGHT = 2
Core.DLAZER_RANGE = 10
Core.DLAZER_SHOOT_SPEED = 400
Core.DLAZER_BEAM_RADIUS = 3
Core.DLAZER_ORBIT_SPEED = 180
Core.DLAZER_LEFT_OFFSET = 0.7
Core.DLAZER_RIGHT_OFFSET = 0.7
Core.DLAZER_ROT_X = 0
Core.DLAZER_ROT_Y = 0
Core.DLAZER_ROT_Z = 0

Core.USE_FIREBALL_HOLD = false
Core.FIREBALL_LEFT_INDEX = 1
Core.FIREBALL_RIGHT_INDEX = 2
Core.FIREBALL_DISTANCE = 5
Core.FIREBALL_HEIGHT = 0
Core.FIREBALL_ORBIT_SPEED = 180
Core.FIREBALL_Y_SPIN_SPEED = 120
Core.FIREBALL_SPHERE_SIZE = 4
Core.FIREBALL_RANGE = 8
Core.FIREBALL_SHOOT_SPEED = 200
Core.FIREBALL_LEFT_OFFSET = 0.7
Core.FIREBALL_RIGHT_OFFSET = 0.7
Core.FIREBALL_ROT_X = 0
Core.FIREBALL_ROT_Y = 0
Core.FIREBALL_ROT_Z = 0

-- Wing Mode (3-Axis)
Core.USE_WING = false
Core.WING_MIN_X = -40; Core.WING_MAX_X = 40
Core.WING_MIN_Y = -40; Core.WING_MAX_Y = 40
Core.WING_MIN_Z = -40; Core.WING_MAX_Z = 40
Core.WING_SPEED_X = 30; Core.WING_SPEED_Y = 30; Core.WING_SPEED_Z = 30

Core.OUTER2_SPIN_MODE = "Y"  -- NEW

-- ═══════════════════════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════════════════════
Core.orbitData = {}
Core.orbitParts = {}
Core.handles = {}
Core.connections = {}
Core.outerOrbitAngle = 0; Core.innerOrbitAngle = 0; Core.innerLazerAngle = 0; Core.lazerOrbitAngle = 0
Core.fireballZAngle = 0; Core.fireballYAngle = 0; Core.fireballPulse = 0
Core.outerSpinAngle = 0; Core.innerSpinAngle = 0
Core.outer2OrbitAngle = 0; Core.outer2SpinAngle = 0
Core.outer3OrbitAngle = 0; Core.outer3SpinAngle = 0
Core.outer4OrbitAngle = 0; Core.outer4SpinAngle = 0
Core.dsZAngle = 0; Core.dsYAngle = 0; Core.dsCenterAngle = 0
Core.shieldAngle = 0
Core.shieldHats = {}
Core.holdSlotHats = {{},{},{},{},{},{},{},{},{},{}}
Core.outerSplitAngle = 0; Core.outer2SplitAngle = 0; Core.outer3SplitAngle = 0; Core.outer4SplitAngle = 0
Core.heldHats = {}
Core.dlazerHats = {}; Core.dlazerShootAngle = 0; Core.dlazerOrbitAngle = 0
Core.fireballHats = {left={}, right={}}; Core.fireballHoldZAngle = 0; Core.fireballHoldYAngle = 0; Core.fireballHoldPulse = 0
Core.shootOutAngle = 0
Core.wingAngleX = 0; Core.wingAngleY = 0; Core.wingAngleZ = 0
Core.wingDirX = 1; Core.wingDirY = 1; Core.wingDirZ = 1

-- ═══════════════════════════════════════════════════════
-- LAZY GETTERS
-- ═══════════════════════════════════════════════════════
local function getPlayers() return game:GetService("Players") end
local function getRunService() return game:GetService("RunService") end
local function getUserInputService() return game:GetService("UserInputService") end

local function getPlayer()
    if not Core._player then
        Core._player = getPlayers().LocalPlayer
        while not Core._player do task.wait(); Core._player = getPlayers().LocalPlayer end
    end
    return Core._player
end

local function getCharacter()
    local plr = getPlayer()
    return plr.Character or plr.CharacterAdded:Wait()
end

local function getHRP()
    local chr = getCharacter()
    return chr:WaitForChild("HumanoidRootPart")
end

function Core.getPlayer() return getPlayer() end
function Core.getCharacter() return getCharacter() end
function Core.getHRP() return getHRP() end

function Core.waitForHRP()
    Core.hrp = getHRP()
    return Core.hrp
end

function Core.isWearable(inst)
    return inst:IsA("Accessory") or inst:IsA("Hat")
end

-- ═══════════════════════════════════════════════════════
-- HELPERS
-- ══════════════════════════════════════════════════════
function Core.cleanupHat(handle)
    local data = Core.orbitData[handle]; if not data then return end
    if data.alignPos then data.alignPos:Destroy() end
    if data.alignOrient then data.alignOrient:Destroy() end
    if data.angularVel then data.angularVel:Destroy() end
    if data.orbitPart then data.orbitPart:Destroy() end
    if Core.connections[handle] then Core.connections[handle]:Disconnect(); Core.connections[handle]=nil end
    Core.orbitData[handle]=nil
    local idx=table.find(Core.handles,handle) if idx then table.remove(Core.handles,idx) end
    local pdx=table.find(Core.orbitParts,data.orbitPart) if pdx then table.remove(Core.orbitParts,pdx) end
    Core.heldHats[handle]=nil
    if Core.shieldHats.left and Core.shieldHats.left.handle==handle then Core.shieldHats.left=nil end
    if Core.shieldHats.right and Core.shieldHats.right.handle==handle then Core.shieldHats.right=nil end
    if Core.dlazerHats.left and Core.dlazerHats.left.handle==handle then Core.dlazerHats.left=nil end
    if Core.dlazerHats.right and Core.dlazerHats.right.handle==handle then Core.dlazerHats.right=nil end
    if Core.fireballHats.left and Core.fireballHats.left.handle==handle then Core.fireballHats.left={} end
    if Core.fireballHats.right and Core.fireballHats.right.handle==handle then Core.fireballHats.right={} end
    for _,slot in ipairs(Core.holdSlotHats) do
        if slot.left and slot.left.handle==handle then slot.left=nil end
        if slot.right and slot.right.handle==handle then slot.right=nil end
    end
end

function Core.setupHatOrbit(accessory)
    if not accessory or not accessory.Parent then return end
    local handle=accessory:FindFirstChild("Handle")
    if not handle or Core.orbitData[handle] then return end
    if #Core.handles>=Core.MAX_HATS then return end
    Core.waitForHRP()
    handle.Massless=true; handle.CustomPhysicalProperties=PhysicalProperties.new(0.0001,0,0,0,0)
    handle.CanCollide=false; handle:BreakJoints()
    for _,w in ipairs(handle:GetChildren()) do if w:IsA("Weld") or w:IsA("Motor6D") then w:Destroy() end end
    handle.AssemblyLinearVelocity=Vector3.zero; handle.AssemblyAngularVelocity=Vector3.zero
    pcall(function() if not handle.Anchored then handle:SetNetworkOwner(getPlayer()) end end)
    local orbitPart=Instance.new("Part",workspace)
    orbitPart.Name="HatOrbitRef_"..accessory.Name; orbitPart.Anchored=true; orbitPart.CanCollide=false; orbitPart.Transparency=1; orbitPart.Size=Vector3.new(0.2,0.2,0.2); orbitPart.Position=getHRP().Position
    local ap=Instance.new("AlignPosition",handle); ap.MaxForce=math.huge; ap.MaxVelocity=math.huge; ap.Responsiveness=200; ap.Enabled=true
    ap.Attachment0=Instance.new("Attachment",handle); ap.Attachment1=Instance.new("Attachment",orbitPart)
    local ao=Instance.new("AlignOrientation",handle); ao.MaxTorque=math.huge; ao.MaxAngularVelocity=math.huge; ao.Responsiveness=200; ao.Enabled=Core.MAGNET_ENABLED
    ao.Attachment0=ap.Attachment0; ao.Attachment1=ap.Attachment1
    local av=Instance.new("BodyAngularVelocity",handle); av.MaxTorque=Vector3.new(math.huge,math.huge,math.huge); av.P=1250; av.AngularVelocity=Vector3.zero
    Core.orbitData[handle]={accessory=accessory,handle=handle,alignPos=ap,alignOrient=ao,angularVel=av,orbitPart=orbitPart}
    table.insert(Core.handles,handle); table.insert(Core.orbitParts,orbitPart)
    Core.connections[handle]=accessory.AncestryChanged:Connect(function(_,p) if p~=getCharacter() then Core.cleanupHat(handle) end end)
    handle.CFrame=orbitPart.CFrame
    task.defer(function() if handle and handle.Parent then handle.CFrame=orbitPart.CFrame end end)
end

function Core.captureAllowedHats()
    local chr = getCharacter()
    if not chr then return end
    Core.waitForHRP()
    for _,c in ipairs(chr:GetChildren()) do if Core.isWearable(c) then local h=c:FindFirstChild("Handle"); if h and not Core.orbitData[h] then Core.setupHatOrbit(c) end end end
end

function Core.removeAllHats() for h in pairs(Core.orbitData) do Core.cleanupHat(h) end end

function Core.setMagnetEnabled(e) Core.MAGNET_ENABLED=e; for _,d in pairs(Core.orbitData) do if d.alignOrient then d.alignOrient.Enabled=e end end end

function Core.resolveAnchor()
    if Core.GIFT_ENABLED and Core.GIFT_TARGET_NAME~="" then local tp=getPlayers():FindFirstChild(Core.GIFT_TARGET_NAME); local tc=tp and tp.Character; local th=tc and tc:FindFirstChild("HumanoidRootPart"); if th then return th end end; return getHRP()
end

function Core.getHatHandlesSorted() local s={} for h in pairs(Core.orbitData) do table.insert(s,h) end; table.sort(s,function(a,b) return a.Name<b.Name end); return s end

-- ═══════════════════════════════════════════════════════
-- HOLD MODES
-- ══════════════════════════════════════════════════════
function Core.setShieldEnabled(enabled)
    Core.USE_SHIELD=enabled
    if not enabled then if Core.shieldHats.left then Core.heldHats[Core.shieldHats.left.handle]=nil end if Core.shieldHats.right then Core.heldHats[Core.shieldHats.right.handle]=nil end Core.shieldHats={} return end
    local s=Core.getHatHandlesSorted()
    if #s<math.max(Core.SHIELD_LEFT_INDEX,Core.SHIELD_RIGHT_INDEX) then Core.USE_SHIELD=false return end
    for _,pick in ipairs({{side="left",idx=Core.SHIELD_LEFT_INDEX},{side="right",idx=Core.SHIELD_RIGHT_INDEX}}) do
        local h=s[pick.idx]; local d=h and Core.orbitData[h]
        if h and d and not Core.shieldHats[pick.side] and not Core.heldHats[h] then Core.heldHats[h]=true; if d.alignOrient then d.alignOrient.Enabled=true end; Core.shieldHats[pick.side]={handle=h,data=d} end
    end; Core.shieldAngle=0
end

function Core.setHoldSlotEnabled(slotIdx, enabled)
    local slot=Core.HOLD_SLOTS[slotIdx]; local hats=Core.holdSlotHats[slotIdx]; slot.USE=enabled
    if not enabled then if hats.left then Core.heldHats[hats.left.handle]=nil end if hats.right then Core.heldHats[hats.right.handle]=nil end hats.left=nil; hats.right=nil return end
    local chr = getCharacter()
    if not chr or not chr:FindFirstChild("LeftHand") or not chr:FindFirstChild("RightHand") then slot.USE=false return end
    local s=Core.getHatHandlesSorted()
    if #s<math.max(slot.LIDX,slot.RIDX) then slot.USE=false return end
    for _,pick in ipairs({{side="left",idx=slot.LIDX},{side="right",idx=slot.RIDX}}) do
        local h=s[pick.idx]; local d=h and Core.orbitData[h]
        if h and d and not hats[pick.side] and not Core.heldHats[h] then Core.heldHats[h]=true; if d.alignOrient then d.alignOrient.Enabled=true end; hats[pick.side]={handle=h,data=d} end
    end
end

function Core.setDLazerHoldEnabled(enabled)
    Core.USE_DLAZER_HOLD=enabled
    if not enabled then if Core.dlazerHats.left then Core.heldHats[Core.dlazerHats.left.handle]=nil end if Core.dlazerHats.right then Core.heldHats[Core.dlazerHats.right.handle]=nil end Core.dlazerHats={} return end
    local chr = getCharacter()
    if not chr or not chr:FindFirstChild("LeftHand") or not chr:FindFirstChild("RightHand") then Core.USE_DLAZER_HOLD=false return end
    local s=Core.getHatHandlesSorted()
    if #s<math.max(Core.DLAZER_LEFT_INDEX,Core.DLAZER_RIGHT_INDEX) then Core.USE_DLAZER_HOLD=false return end
    for _,pick in ipairs({{side="left",idx=Core.DLAZER_LEFT_INDEX},{side="right",idx=Core.DLAZER_RIGHT_INDEX}}) do
        local h=s[pick.idx]; local d=h and Core.orbitData[h]
        if h and d and not Core.dlazerHats[pick.side] and not Core.heldHats[h] then Core.heldHats[h]=true; if d.alignOrient then d.alignOrient.Enabled=true end; Core.dlazerHats[pick.side]={handle=h,data=d} end
    end
end

function Core.ensureFireballStructure()
    if type(Core.fireballHats)~="table" then Core.fireballHats={} end
    if type(Core.fireballHats.left)~="table" then Core.fireballHats.left={} end
    if type(Core.fireballHats.right)~="table" then Core.fireballHats.right={} end
end

function Core.setFireballHoldEnabled(enabled)
    Core.USE_FIREBALL_HOLD=enabled; Core.ensureFireballStructure()
    if not enabled then if Core.fireballHats.left and Core.fireballHats.left.handle then Core.heldHats[Core.fireballHats.left.handle]=nil end if Core.fireballHats.right and Core.fireballHats.right.handle then Core.heldHats[Core.fireballHats.right.handle]=nil end Core.fireballHats.left={}; Core.fireballHats.right={} return end
    local chr = getCharacter()
    if not chr or not chr:FindFirstChild("LeftHand") or not chr:FindFirstChild("RightHand") then Core.USE_FIREBALL_HOLD=false return end
    local s=Core.getHatHandlesSorted()
    if #s<math.max(Core.FIREBALL_LEFT_INDEX,Core.FIREBALL_RIGHT_INDEX) then Core.USE_FIREBALL_HOLD=false return end
    if Core.fireballHats.left and Core.fireballHats.left.handle then Core.heldHats[Core.fireballHats.left.handle]=nil end
    if Core.fireballHats.right and Core.fireballHats.right.handle then Core.heldHats[Core.fireballHats.right.handle]=nil end
    Core.fireballHats.left={}; Core.fireballHats.right={}
    for _,pick in ipairs({{side="left",idx=Core.FIREBALL_LEFT_INDEX},{side="right",idx=Core.FIREBALL_RIGHT_INDEX}}) do
        local h=s[pick.idx]; local d=h and Core.orbitData[h]
        if h and d and not Core.heldHats[h] then Core.heldHats[h]=true; if d.alignOrient then d.alignOrient.Enabled=true end; Core.fireballHats[pick.side]={handle=h,data=d} end
    end
    if not (Core.fireballHats.left and Core.fireballHats.left.handle) and not (Core.fireballHats.right and Core.fireballHats.right.handle) then
        Core.USE_FIREBALL_HOLD=false
        if Core.fireballHats.left and Core.fireballHats.left.handle then Core.heldHats[Core.fireballHats.left.handle]=nil end
        if Core.fireballHats.right and Core.fireballHats.right.handle then Core.heldHats[Core.fireballHats.right.handle]=nil end
    end
end

-- ═══════════════════════════════════════════════════════
-- UPDATE FUNCTIONS
-- ══════════════════════════════════════════════════════
function Core.updateShield(dt)
    if not Core.USE_SHIELD then return end; if not (Core.shieldHats.left or Core.shieldHats.right) then return end
    local a=Core.resolveAnchor(); local b=-a.CFrame.LookVector; local r=a.CFrame.RightVector; local u=a.CFrame.UpVector
    Core.shieldAngle=(Core.shieldAngle+math.rad(Core.SHIELD_SPEED)*dt)%(math.pi*2)
    for side,hd in pairs(Core.shieldHats) do
        if hd and hd.handle and hd.handle.Parent and hd.data and hd.data.orbitPart then
            local o=(side=="left") and math.pi or 0; local ang=Core.shieldAngle+o
            local tp=a.Position+b*Core.SHIELD_DISTANCE+u*Core.SHIELD_HEIGHT+r*math.cos(ang)*Core.SHIELD_RADIUS+u*math.sin(ang)*Core.SHIELD_RADIUS
            hd.data.orbitPart.CFrame=CFrame.new(tp)*CFrame.Angles(0,math.rad(90),0)
        end
    end
end

function Core.updateHoldSlot(slotIdx)
    local slot=Core.HOLD_SLOTS[slotIdx]; local hats=Core.holdSlotHats[slotIdx]
    if not slot.USE then return end; if not (hats.left or hats.right) then return end
    local chr = getCharacter()
    if not chr then return end
    local lh=chr:FindFirstChild("LeftHand"); local rh=chr:FindFirstChild("RightHand"); if not lh or not rh then return end
    local rot=CFrame.Angles(math.rad(slot.RX),math.rad(slot.RY),math.rad(slot.RZ))
    local ld=hats.left
    if ld and ld.handle and ld.handle.Parent and ld.data and ld.data.orbitPart then ld.data.orbitPart.CFrame=lh.CFrame*CFrame.new(slot.LOFF,slot.HGT,slot.DIST)*rot end
    local rd=hats.right
    if rd and rd.handle and rd.handle.Parent and rd.data and rd.data.orbitPart then rd.data.orbitPart.CFrame=rh.CFrame*CFrame.new(slot.ROFF,slot.HGT,slot.DIST)*rot end
end

function Core.updateDLazerHold(dt)
    if not Core.USE_DLAZER_HOLD then return end; if not (Core.dlazerHats.left or Core.dlazerHats.right) then return end
    local chr = getCharacter()
    if not chr then return end
    local lh=chr:FindFirstChild("LeftHand"); local rh=chr:FindFirstChild("RightHand"); if not lh or not rh then return end
    Core.dlazerShootAngle=(Core.dlazerShootAngle+math.rad(Core.DLAZER_SHOOT_SPEED)*dt)%(math.pi*2)
    Core.dlazerOrbitAngle=(Core.dlazerOrbitAngle+math.rad(Core.DLAZER_ORBIT_SPEED)*dt)%(math.pi*2)
    local rot=CFrame.Angles(math.rad(Core.DLAZER_ROT_X),math.rad(Core.DLAZER_ROT_Y),math.rad(Core.DLAZER_ROT_Z))
    local ld=Core.dlazerHats.left
    if ld and ld.handle and ld.handle.Parent and ld.data and ld.data.orbitPart then
        local pulse=math.sin(Core.dlazerShootAngle)*Core.DLAZER_RANGE
        local orbitX=math.cos(Core.dlazerOrbitAngle)*Core.DLAZER_BEAM_RADIUS; local orbitY=math.sin(Core.dlazerOrbitAngle)*Core.DLAZER_BEAM_RADIUS
        local pulseOffset=CFrame.new(orbitX,orbitY,pulse)
        ld.data.orbitPart.CFrame=lh.CFrame*CFrame.new(Core.DLAZER_LEFT_OFFSET,Core.DLAZER_HEIGHT,-Core.DLAZER_DISTANCE)*CFrame.Angles(math.rad(Core.DLAZER_ROT_X),math.rad(Core.DLAZER_ROT_Y),math.rad(Core.DLAZER_ROT_Z))*pulseOffset
    end
    local rd=Core.dlazerHats.right
    if rd and rd.handle and rd.handle.Parent and rd.data and rd.data.orbitPart then
        local pulse=math.sin(Core.dlazerShootAngle)*Core.DLAZER_RANGE
        local orbitX=math.cos(Core.dlazerOrbitAngle)*Core.DLAZER_BEAM_RADIUS; local orbitY=math.sin(Core.dlazerOrbitAngle)*Core.DLAZER_BEAM_RADIUS
        local pulseOffset=CFrame.new(orbitX,orbitY,pulse)
        rd.data.orbitPart.CFrame=rh.CFrame*CFrame.new(Core.DLAZER_RIGHT_OFFSET,Core.DLAZER_HEIGHT,-Core.DLAZER_DISTANCE)*CFrame.Angles(math.rad(Core.DLAZER_ROT_X),math.rad(Core.DLAZER_ROT_Y),math.rad(Core.DLAZER_ROT_Z))*pulseOffset
    end
end

function Core.ensureFireballStructure()
    if type(Core.fireballHats)~="table" then Core.fireballHats={} end
    if type(Core.fireballHats.left)~="table" then Core.fireballHats.left={} end
    if type(Core.fireballHats.right)~="table" then Core.fireballHats.right={} end
end

function Core.setFireballHoldEnabled(enabled)
    Core.USE_FIREBALL_HOLD=enabled; Core.ensureFireballStructure()
    if not enabled then if Core.fireballHats.left and Core.fireballHats.left.handle then Core.heldHats[Core.fireballHats.left.handle]=nil end if Core.fireballHats.right and Core.fireballHats.right.handle then Core.heldHats[Core.fireballHats.right.handle]=nil end Core.fireballHats.left={}; Core.fireballHats.right={} return end
    local chr = getCharacter()
    if not chr or not chr:FindFirstChild("LeftHand") or not chr:FindFirstChild("RightHand") then Core.USE_FIREBALL_HOLD=false return end
    local s=Core.getHatHandlesSorted()
    if #s<math.max(Core.FIREBALL_LEFT_INDEX,Core.FIREBALL_RIGHT_INDEX) then Core.USE_FIREBALL_HOLD=false return end
    if Core.fireballHats.left and Core.fireballHats.left.handle then Core.heldHats[Core.fireballHats.left.handle]=nil end
    if Core.fireballHats.right and Core.fireballHats.right.handle then Core.heldHats[Core.fireballHats.right.handle]=nil end
    Core.fireballHats.left={}; Core.fireballHats.right={}
    for _,pick in ipairs({{side="left",idx=Core.FIREBALL_LEFT_INDEX},{side="right",idx=Core.FIREBALL_RIGHT_INDEX}}) do
        local h=s[pick.idx]; local d=h and Core.orbitData[h]
        if h and d and not Core.heldHats[h] then Core.heldHats[h]=true; if d.alignOrient then d.alignOrient.Enabled=true end; Core.fireballHats[pick.side]={handle=h,data=d} end
    end
    if not (Core.fireballHats.left and Core.fireballHats.left.handle) and not (Core.fireballHats.right and Core.fireballHats.right.handle) then
        Core.USE_FIREBALL_HOLD=false
        if Core.fireballHats.left and Core.fireballHats.left.handle then Core.heldHats[Core.fireballHats.left.handle]=nil end
        if Core.fireballHats.right and Core.fireballHats.right.handle then Core.heldHats[Core.fireballHats.right.handle]=nil end
    end
end

function Core.updateFireballHold(dt)
    if not Core.USE_FIREBALL_HOLD then return end; Core.ensureFireballStructure()
    local chr = getCharacter()
    if not chr then Core.USE_FIREBALL_HOLD=false return end
    local lh=chr:FindFirstChild("LeftHand"); local rh=chr:FindFirstChild("RightHand"); if not lh or not rh then Core.USE_FIREBALL_HOLD=false return end
    local leftOk=Core.fireballHats.left and Core.fireballHats.left.handle and Core.fireballHats.left.handle.Parent
    local rightOk=Core.fireballHats.right and Core.fireballHats.right.handle and Core.fireballHats.right.handle.Parent
    if not leftOk and not rightOk then Core.USE_FIREBALL_HOLD=false; if Core.fireballHats.left and Core.fireballHats.left.handle then Core.heldHats[Core.fireballHats.left.handle]=nil end if Core.fireballHats.right and Core.fireballHats.right.handle then Core.heldHats[Core.fireballHats.right.handle]=nil end Core.fireballHats.left={}; Core.fireballHats.right={} return end
    Core.fireballHoldZAngle=(Core.fireballHoldZAngle+math.rad(Core.FIREBALL_ORBIT_SPEED)*dt)%(math.pi*2)
    Core.fireballHoldYAngle=(Core.fireballHoldYAngle+math.rad(Core.FIREBALL_Y_SPIN_SPEED)*dt)%(math.pi*2)
    Core.fireballHoldPulse=(Core.fireballHoldPulse+math.rad(Core.FIREBALL_SHOOT_SPEED)*dt)%(math.pi*2)
    local sphereRadius=Core.FIREBALL_SPHERE_SIZE
    local pulseAmount=math.sin(Core.fireballHoldPulse)*Core.FIREBALL_RANGE
    local currentDistance=Core.FIREBALL_DISTANCE+pulseAmount
    if leftOk then
        local ld=Core.fireballHats.left
        if ld and ld.data and ld.data.orbitPart then
            local theta=Core.fireballHoldZAngle; local phi=Core.fireballHoldYAngle
            local x=sphereRadius*math.sin(phi)*math.cos(theta); local y=sphereRadius*math.sin(phi)*math.sin(theta); local z=sphereRadius*math.cos(phi)
            local handCFrame=lh.CFrame*CFrame.new(-Core.FIREBALL_LEFT_OFFSET,Core.FIREBALL_HEIGHT,-currentDistance)*CFrame.Angles(math.rad(Core.FIREBALL_ROT_X),math.rad(Core.FIREBALL_ROT_Y),math.rad(Core.FIREBALL_ROT_Z))
            local orbitOffset=handCFrame:PointToWorldSpace(Vector3.new(x,y,z))-handCFrame.Position
            ld.data.orbitPart.CFrame=handCFrame*CFrame.new(orbitOffset.X,orbitOffset.Y,orbitOffset.Z)
        end
    else if Core.fireballHats.left and Core.fireballHats.left.handle then Core.heldHats[Core.fireballHats.left.handle]=nil end Core.fireballHats.left={} end
    if rightOk then
        local rd=Core.fireballHats.right
        if rd and rd.data and rd.data.orbitPart then
            local theta=Core.fireballHoldZAngle+math.pi; local phi=Core.fireballHoldYAngle+math.pi
            local x=sphereRadius*math.sin(phi)*math.cos(theta); local y=sphereRadius*math.sin(phi)*math.sin(theta); local z=sphereRadius*math.cos(phi)
            local handCFrame=rh.CFrame*CFrame.new(Core.FIREBALL_RIGHT_OFFSET,Core.FIREBALL_HEIGHT,-currentDistance)*CFrame.Angles(math.rad(Core.FIREBALL_ROT_X),math.rad(Core.FIREBALL_ROT_Y),math.rad(Core.FIREBALL_ROT_Z))
            local orbitOffset=handCFrame:PointToWorldSpace(Vector3.new(x,y,z))-handCFrame.Position
            rd.data.orbitPart.CFrame=handCFrame*CFrame.new(orbitOffset.X,orbitOffset.Y,orbitOffset.Z)
        end
    else if Core.fireballHats.right and Core.fireballHats.right.handle then Core.heldHats[Core.fireballHats.right.handle]=nil end Core.fireballHats.right={} end
end

-- ═══════════════════════════════════════════════════════
-- WING MODE (Dynamic Axis Mapping)
-- ══════════════════════════════════════════════════════
function Core.updateWingMode(dt)
    if not Core.USE_WING or not Core.USE_OUTER2 then return end
    
    local spinMode = Core.OUTER2_SPIN_MODE
    local angles = {X=0, Y=0, Z=0}
    local dirs = {X=Core.wingDirX, Y=Core.wingDirY, Z=Core.wingDirZ}
    
    -- Map internal angles to axes based on Spin Mode
    if spinMode == "X" then
        angles.X = Core.wingAngleX  -- Primary
        angles.Y = Core.wingAngleY  -- Secondary
        angles.Z = Core.wingAngleZ  -- Tertiary
    elseif spinMode == "Y" then
        angles.Y = Core.wingAngleX  -- Primary
        angles.X = Core.wingAngleY  -- Secondary
        angles.Z = Core.wingAngleZ  -- Tertiary
    else -- Z
        angles.Z = Core.wingAngleX  -- Primary
        angles.X = Core.wingAngleY  -- Secondary
        angles.Y = Core.wingAngleZ  -- Tertiary
    end
    
    -- Update each axis
    for axis, angleRef in pairs({X="wingAngleX", Y="wingAngleY", Z="wingAngleZ"}) do
        local minKey = "WING_MIN_"..axis
        local maxKey = "WING_MAX_"..axis
        local speedKey = "WING_SPEED_"..axis
        local dirKey = "wingDir"..axis
        
        if Core[maxKey] ~= Core[minKey] then
            local minRad = math.rad(Core[minKey])
            local maxRad = math.rad(Core[maxKey])
            Core[angleRef] = Core[angleRef] + (math.rad(Core[speedKey]) * dt * Core[dirKey])
            if Core[angleRef] >= maxRad then Core[angleRef] = maxRad; Core[dirKey] = -1
            elseif Core[angleRef] <= minRad then Core[angleRef] = minRad; Core[dirKey] = 1 end
        end
    end
    
    -- Apply mapped angles back
    if spinMode == "X" then
        Core.wingAngleX = angles.X
        Core.wingAngleY = angles.Y
        Core.wingAngleZ = angles.Z
    elseif spinMode == "Y" then
        Core.wingAngleX = angles.Y  -- Primary was Y
        Core.wingAngleY = angles.X  -- Secondary was X
        Core.wingAngleZ = angles.Z
    else -- Z
        Core.wingAngleX = angles.Y  -- Secondary was X
        Core.wingAngleY = angles.Z  -- Tertiary was Z
        Core.wingAngleZ = angles.X  -- Primary was Z
    end
    
    -- Update dirs back
    Core.wingDirX = dirs.X
    Core.wingDirY = dirs.Y
    Core.wingDirZ = dirs.Z
end

-- ═══════════════════════════════════════════════════════
-- RENDER LOOP
-- ══════════════════════════════════════════════════════
function Core.startRenderLoop()
    local TWO_PI = math.pi * 2
    local V3_ZERO = Vector3.zero
    local CF_ID = CFrame.identity
    local CF_NEW, CF_ANGLES, CF_LOOKAT = CFrame.new, CFrame.Angles, CFrame.lookAt
    local function squarePos(progress,radius,rot)
        local sideLen=2*radius; local perimeter=8*radius; local perimeterAngle=progress*perimeter
        local side=math.floor(perimeterAngle/sideLen)%4; local sideProgress=(perimeterAngle%sideLen)/sideLen
        local x,y
        if side==0 then x=radius; y=-radius+sideProgress*sideLen elseif side==1 then x=radius-sideProgress*sideLen; y=radius
        elseif side==2 then x=-radius; y=radius-sideProgress*sideLen else x=-radius+sideProgress*sideLen; y=-radius end
        local cr=math.cos(rot); local sr=math.sin(rot); return x*cr-y*sr, x*sr+y*cr
    end

    getRunService().RenderStepped:Connect(function(dt)
        if not Core.isActive then return end
        if not Core.hrp or not Core.hrp.Parent then
            Core.hrp = getHRP()
            return
        end
        
        Core.outerOrbitAngle=(Core.outerOrbitAngle+math.rad(Core.ORBIT_SPEED)*dt)%TWO_PI
        Core.outerSpinAngle=(Core.outerSpinAngle+math.rad(Core.SPIN_SPEED*60)*dt)%TWO_PI
        Core.outerSplitAngle=(Core.outerSplitAngle-math.rad(Core.ORBIT_SPEED)*dt)%TWO_PI
        
        if Core.USE_OUTER2 then
            Core.outer2OrbitAngle=(Core.outer2OrbitAngle+math.rad(Core.OUTER2_SPEED)*dt)%TWO_PI
            if not Core.USE_WING then
                Core.outer2SpinAngle=(Core.outer2SpinAngle+math.rad(Core.OUTER2_SPIN*60)*dt)%TWO_PI
            end
            Core.outer2SplitAngle=(Core.outer2SplitAngle-math.rad(Core.OUTER2_SPEED)*dt)%TWO_PI
            Core.updateWingMode(dt)
        end
        if Core.USE_OUTER3 then Core.outer3OrbitAngle=(Core.outer3OrbitAngle+math.rad(Core.OUTER3_SPEED)*dt)%TWO_PI; Core.outer3SpinAngle=(Core.outer3SpinAngle+math.rad(Core.OUTER3_SPIN*60)*dt)%TWO_PI; Core.outer3SplitAngle=(Core.outer3SplitAngle-math.rad(Core.OUTER3_SPEED)*dt)%TWO_PI end
        if Core.USE_OUTER4 then Core.outer4OrbitAngle=(Core.outer4OrbitAngle+math.rad(Core.OUTER4_SPEED)*dt)%TWO_PI; Core.outer4SpinAngle=(Core.outer4SpinAngle+math.rad(Core.OUTER4_SPIN*60)*dt)%TWO_PI; Core.outer4SplitAngle=(Core.outer4SplitAngle-math.rad(Core.OUTER4_SPEED)*dt)%TWO_PI end
        
        if Core.USE_INNER_RING then
            Core.innerOrbitAngle=(Core.innerOrbitAngle+math.rad(Core.INNER_ORBIT_SPEED)*dt)%TWO_PI; Core.innerSpinAngle=(Core.innerSpinAngle+math.rad(Core.INNER_SPIN_SPEED*60)*dt)%TWO_PI
            if Core.INNER_MODE=="Lazer" or Core.INNER_MODE=="DoubleLazer" then Core.innerLazerAngle=(Core.innerLazerAngle+math.rad(Core.INNER_LAZER_SPEED)*dt)%TWO_PI; Core.lazerOrbitAngle=(Core.lazerOrbitAngle+math.rad(Core.INNER_LAZER_ORBIT_SPEED)*dt)%TWO_PI end
            if Core.INNER_MODE=="Fireball" then Core.fireballZAngle=(Core.fireballZAngle+math.rad(Core.FB_ORBIT_SPEED)*dt)%TWO_PI; Core.fireballYAngle=(Core.fireballYAngle+math.rad(Core.FB_Y_SPIN_SPEED)*dt)%TWO_PI; Core.fireballPulse=(Core.fireballPulse+math.rad(Core.FB_SHOOT_SPEED)*dt)%TWO_PI end
            if Core.INNER_MODE=="DoubleStar" then Core.dsZAngle=(Core.dsZAngle+math.rad(Core.DS_ORBIT_SPEED)*dt)%TWO_PI; Core.dsYAngle=(Core.dsYAngle+math.rad(Core.DS_Y_SPIN_SPEED)*dt)%TWO_PI; Core.dsCenterAngle=(Core.dsCenterAngle+math.rad(Core.DS_CENTER_SPEED)*dt)%TWO_PI end
        end
        
        Core.shootOutAngle=(Core.shootOutAngle+math.rad(Core.SHOOT_OUT_SPEED)*dt)%TWO_PI
        
        Core.updateShield(dt)
        for i=1,10 do Core.updateHoldSlot(i) end
        Core.updateDLazerHold(dt)
        Core.updateFireballHold(dt)
        
        local availableIndices={} for i=1,#Core.orbitParts do local h=Core.handles[i]; if h and not Core.heldHats[h] then table.insert(availableIndices,i) end end
        local availCount=#availableIndices; if availCount==0 then return end
        
        local a=Core.resolveAnchor(); local b=-a.CFrame.LookVector; local r=a.CFrame.RightVector; local u=a.CFrame.UpVector
        local function uv(mode) if mode=="X" then return u,b elseif mode=="Z" then return r,u else return r,b end end
        local u1,v1=uv(Core.ORBIT_MODE); local u2,v2=uv(Core.OUTER2_MODE); local u3,v3=uv(Core.OUTER3_MODE); local u4,v4=uv(Core.OUTER4_MODE); local uIn,vIn=uv(Core.INNER_ORBIT_MODE)
        local spinVec=(Core.SPIN_MODE=="X") and Vector3.new(10,0,0) or (Core.SPIN_MODE=="Y") and Vector3.new(0,10,0) or Vector3.new(0,0,10)
        
        local innerCap=Core.USE_INNER_RING and math.min(Core.INNER_COUNT,availCount) or 0; local rem=availCount-innerCap
        local o2c=Core.USE_OUTER2 and math.min(Core.OUTER2_COUNT,rem) or 0; rem=rem-o2c
        local o3c=Core.USE_OUTER3 and math.min(Core.OUTER3_COUNT,rem) or 0; rem=rem-o3c
        local o4c=Core.USE_OUTER4 and math.min(Core.OUTER4_COUNT,rem) or 0; local o1c=math.max(rem-o4c,0)
        local alpha=1-math.exp(-Core.SMOOTHNESS*10*dt)
        
        for availIdx,i in ipairs(availableIndices) do
            local op=Core.orbitParts[i]; local h=Core.handles[i]; local d=Core.orbitData[h]; if not d then continue end
            local tp; local availOuterIdx=availIdx-innerCap; local isIn=availIdx<=innerCap; local isO2=not isIn and availOuterIdx<=o2c; local isO3=not isIn and not isO2 and availOuterIdx<=(o2c+o3c); local isO4=not isIn and not isO2 and not isO3 and availOuterIdx<=(o2c+o3c+o4c)
            
            if isIn then
                local ringIdx=availIdx-1; local ringCount=innerCap
                if Core.INNER_MODE=="Ring" then local cp=a.Position+b*Core.INNER_DISTANCE+u*Core.INNER_HEIGHT_OFFSET; local ang=(2*math.pi/Core.INNER_COUNT)*(availIdx-1)+Core.innerOrbitAngle; tp=cp+uIn*math.cos(ang)*Core.INNER_ORBIT_RADIUS+vIn*math.sin(ang)*Core.INNER_ORBIT_RADIUS
                elseif Core.INNER_MODE=="Lazer" then local osc=math.sin(Core.innerLazerAngle)*Core.INNER_LAZER_RANGE; local bd=Core.INNER_LAZER_DISTANCE+osc; if availIdx==innerCap then local ra=Core.lazerOrbitAngle; local ro=r*math.cos(ra)*Core.INNER_LAZER_RADIUS+u*math.sin(ra)*Core.INNER_LAZER_RADIUS; tp=a.Position+b*bd+u*Core.INNER_LAZER_HEIGHT+ro else local so=(availIdx-1)*0.03; local sp=(availIdx-1)*0.02; tp=a.Position+b*(bd+so)+u*(Core.INNER_LAZER_HEIGHT+sp) end
                elseif Core.INNER_MODE=="DoubleLazer" then local half=math.ceil(innerCap/2); local isBeam1=availIdx<=half; local beamIdx=isBeam1 and (availIdx-1) or (availIdx-half-1); local beamCount=isBeam1 and half or (innerCap-half); local isTip=(isBeam1 and availIdx==half) or (not isBeam1 and availIdx==innerCap); local osc=math.sin(Core.innerLazerAngle)*Core.INNER_LAZER_RANGE; local bd=Core.INNER_LAZER_DISTANCE+osc; local gap=Core.INNER_BEAM_GAP; local sideOffset=isBeam1 and (-gap/2) or (gap/2); local beamCenter=a.Position+b*bd+u*Core.INNER_LAZER_HEIGHT+r*sideOffset; if isTip then local ra=Core.lazerOrbitAngle; local ro=r*math.cos(ra)*Core.INNER_LAZER_RADIUS+u*math.sin(ra)*Core.INNER_LAZER_RADIUS; tp=beamCenter+ro else local trailIndex=beamCount-beamIdx-1; local trailDist=trailIndex*0.8; tp=beamCenter-b*trailDist end
                elseif Core.INNER_MODE=="DoubleStar" then local sc=math.ceil(innerCap/2); local isA=availIdx<=sc; local gi=isA and (availIdx-1) or (availIdx-sc-1); local gs=math.max(isA and sc or (innerCap-sc),1); local bc=a.Position+b*Core.DS_DISTANCE+u*Core.DS_HEIGHT; local sa=Core.dsCenterAngle+(isA and 0 or math.pi); local scp=bc+r*math.cos(sa)*Core.DS_CENTER_RADIUS+b*math.sin(sa)*Core.DS_CENTER_RADIUS; local ph=(2*math.pi/gs)*gi; local za=Core.dsZAngle+ph; local lx=math.sin(za)*Core.DS_SIZE; local ly=math.cos(za)*Core.DS_SIZE; local cr=math.cos(Core.dsYAngle); local sr=math.sin(Core.dsYAngle); local wz=lx*cr; local wx=lx*sr; tp=scp+b*wz+r*wx+u*ly
                else local ro=math.sin(Core.fireballPulse)*Core.FB_RANGE; local bd=Core.FB_DISTANCE+ro; local ph=(2*math.pi/innerCap)*(availIdx-1); local za=Core.fireballZAngle+ph; local lx=math.sin(za)*Core.FB_SIZE; local ly=math.cos(za)*Core.FB_SIZE; local cr=math.cos(Core.fireballYAngle); local sr=math.sin(Core.fireballYAngle); local wz=lx*cr; local wx=lx*sr; tp=a.Position+b*(bd+wz)+r*wx+u*(Core.FB_HEIGHT+ly) end
            else
                local ringCount,ringIdx,ringAngle,ringSplitAngle,ringSplitRatio,ringRot,axisU,axisV,ringRadius,cp,useSplit,useShootOut,splitRatio,shootOutRange,shootOutSpeed,shootOutOrbitSpeed
                if availOuterIdx<=o2c then ringCount=o2c; ringIdx=availOuterIdx-1; ringAngle=Core.outer2OrbitAngle; ringSplitAngle=Core.outer2SplitAngle; ringSplitRatio=Core.OUTER2_SPLIT_RATIO; ringRot=math.rad(Core.OUTER2_ROTATION); cp=a.Position+b*Core.OUTER2_DISTANCE+u*Core.OUTER2_HEIGHT; axisU,axisV=u2,v2; ringRadius=Core.OUTER2_RADIUS; useSplit=Core.USE_OUTER2_SPLIT; splitRatio=Core.OUTER2_SPLIT_RATIO; useShootOut=false
                elseif availOuterIdx<=o2c+o3c then ringCount=o3c; ringIdx=availOuterIdx-o2c-1; ringAngle=Core.outer3OrbitAngle; ringSplitAngle=Core.outer3SplitAngle; ringSplitRatio=Core.OUTER3_SPLIT_RATIO; ringRot=math.rad(Core.OUTER3_ROTATION); cp=a.Position+b*Core.OUTER3_DISTANCE+u*Core.OUTER3_HEIGHT; axisU,axisV=u3,v3; ringRadius=Core.OUTER3_RADIUS; useSplit=Core.USE_OUTER3_SPLIT; splitRatio=Core.OUTER3_SPLIT_RATIO; useShootOut=false
                elseif availOuterIdx<=o2c+o3c+o4c then ringCount=o4c; ringIdx=availOuterIdx-o2c-o3c-1; ringAngle=Core.outer4OrbitAngle; ringSplitAngle=Core.outer4SplitAngle; ringSplitRatio=Core.OUTER4_SPLIT_RATIO; ringRot=math.rad(Core.OUTER4_ROTATION); cp=a.Position+b*Core.OUTER4_DISTANCE+u*Core.OUTER4_HEIGHT; axisU,axisV=u4,v4; ringRadius=Core.OUTER4_RADIUS; useSplit=Core.USE_OUTER4_SPLIT; splitRatio=Core.OUTER4_SPLIT_RATIO; useShootOut=false
                else ringCount=o1c; ringIdx=availOuterIdx-o2c-o3c-o4c-1; ringAngle=Core.outerOrbitAngle; ringSplitAngle=Core.outerSplitAngle; ringSplitRatio=Core.SPLIT_RATIO; ringRot=math.rad(Core.ORBIT_ROTATION); cp=a.Position+b*Core.DISTANCE+u*Core.HEIGHT_OFFSET; axisU,axisV=u1,v1; ringRadius=Core.ORBIT_RADIUS; useSplit=Core.USE_SPLIT; splitRatio=Core.SPLIT_RATIO; useShootOut=Core.USE_SHOOT_OUT; shootOutRange=Core.SHOOT_OUT_RANGE; shootOutSpeed=Core.SHOOT_OUT_SPEED; shootOutOrbitSpeed=Core.SHOOT_OUT_ORBIT_SPEED end
                
                if useShootOut then local hatAngle=(2*math.pi/ringCount)*ringIdx+ringAngle; local shootOutProgress=(math.sin(Core.shootOutAngle)+1)*0.5; local radialDistance=ringRadius+shootOutProgress*shootOutRange; local orbitAngle=ringAngle; if Core.USE_SHOOT_OUT_ORBIT then orbitAngle=ringAngle+(shootOutOrbitSpeed/60)*tick()%TWO_PI end; local dirX=math.cos(hatAngle); local dirY=math.sin(hatAngle); if Core.USE_SHOOT_OUT_ORBIT then local cosO=math.cos(orbitAngle-ringAngle); local sinO=math.sin(orbitAngle-ringAngle); local rotatedX=dirX*cosO-dirY*sinO; local rotatedY=dirX*sinO+dirY*cosO; dirX,dirY=rotatedX,rotatedY end; tp=cp+axisU*(dirX*radialDistance)+axisV*(dirY*radialDistance)
                elseif useSplit then local sc=math.floor(ringCount*splitRatio); local fwd=ringIdx<sc; local ri=fwd and ringIdx or (ringIdx-sc); local ang=fwd and ringAngle or ringSplitAngle; local cap=fwd and sc or (ringCount-sc); local a2=(2*math.pi/math.max(cap,1))*ri+ang; tp=cp+axisU*math.cos(a2)*ringRadius+axisV*math.sin(a2)*ringRadius
                else local ang=(2*math.pi/math.max(ringCount,1))*ringIdx+ringAngle; tp=cp+axisU*math.cos(ang)*ringRadius+axisV*math.sin(ang)*ringRadius end
                
                if isO2 and Core.USE_WING then
                    local wingCFrame = CFrame.Angles(Core.wingAngleX, Core.wingAngleY, Core.wingAngleZ)
                    tp = (tp - cp) + cp
                    Core.orbitParts[i].CFrame = CFrame.new(tp) * wingCFrame
                end
            end
            
            Core.orbitParts[i].Position = Core.orbitParts[i].Position:Lerp(tp, alpha)
            if not (isO2 and Core.USE_WING) then
                if Core.MAGNET_ENABLED then local lk=CF_LOOKAT(tp,a.Position); local sa=isIn and Core.innerSpinAngle or (isO2 and Core.outer2SpinAngle or (isO3 and Core.outer3SpinAngle or (isO4 and Core.outer4SpinAngle or Core.outerSpinAngle))); local sc=CF_ID; if Core.SPIN_MODE=="Y" then sc=CF_ANGLES(0,sa,0) elseif Core.SPIN_MODE=="X" then sc=CF_ANGLES(sa,0,0) elseif Core.SPIN_MODE=="Z" then sc=CF_ANGLES(0,0,sa) end; Core.orbitParts[i].CFrame=lk*sc; if d.angularVel then d.angularVel.AngularVelocity=V3_ZERO end else Core.orbitParts[i].CFrame=CF_NEW(tp); if d.angularVel then d.angularVel.AngularVelocity=spinVec end end
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════
-- CHARACTER HOOKS
-- ══════════════════════════════════════════════════════
function Core.onChar(c)
    Core.chr = c
    Core.hrp = c:WaitForChild("HumanoidRootPart")
    Core.removeAllHats()
    task.wait(0.3)
    Core.captureAllowedHats()
    c.ChildAdded:Connect(function(ch)
        task.wait()
        if Core.isWearable(ch) then Core.setupHatOrbit(ch) end
    end)
end

task.spawn(function()
    local chr = getCharacter()
    Core.onChar(chr)
    getPlayer().CharacterAdded:Connect(Core.onChar)
end)

-- ══════════════════════════════════════════════════════
-- INIT
-- ════════════════════════════════════════════════════
function Core.Init(GUI, Wing)
    Core.GUI = GUI
    Core.Wing = Wing
    
    GUI.Create(Core)
    
    Core.startRenderLoop()
    
    task.spawn(function()
        task.wait(1)
        Core.captureAllowedHats()
    end)
    
    print("🔥 Hat Orbit Core Ready")
end

return Core
