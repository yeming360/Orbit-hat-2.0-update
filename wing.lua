-- wing.lua
local Wing = {}

function Wing.Update(Core, dt)
    if not Core.USE_WING or not Core.USE_OUTER2 then return end
    
    -- X Axis (Roll)
    if Core.WING_MAX_X ~= Core.WING_MIN_X then
        local minRad = math.rad(Core.WING_MIN_X)
        local maxRad = math.rad(Core.WING_MAX_X)
        Core.wingAngleX = Core.wingAngleX + (math.rad(Core.WING_SPEED_X) * dt * Core.wingDirX)
        if Core.wingAngleX >= maxRad then Core.wingAngleX = maxRad; Core.wingDirX = -1
        elseif Core.wingAngleX <= minRad then Core.wingAngleX = minRad; Core.wingDirX = 1 end
    end
    
    -- Y Axis (Pitch)
    if Core.WING_MAX_Y ~= Core.WING_MIN_Y then
        local minRad = math.rad(Core.WING_MIN_Y)
        local maxRad = math.rad(Core.WING_MAX_Y)
        Core.wingAngleY = Core.wingAngleY + (math.rad(Core.WING_SPEED_Y) * dt * Core.wingDirY)
        if Core.wingAngleY >= maxRad then Core.wingAngleY = maxRad; Core.wingDirY = -1
        elseif Core.wingAngleY <= minRad then Core.wingAngleY = minRad; Core.wingDirY = 1 end
    end
    
    -- Z Axis (Yaw)
    if Core.WING_MAX_Z ~= Core.WING_MIN_Z then
        local minRad = math.rad(Core.WING_MIN_Z)
        local maxRad = math.rad(Core.WING_MAX_Z)
        Core.wingAngleZ = Core.wingAngleZ + (math.rad(Core.WING_SPEED_Z) * dt * Core.wingDirZ)
        if Core.wingAngleZ >= maxRad then Core.wingAngleZ = maxRad; Core.wingDirZ = -1
        elseif Core.wingAngleZ <= minRad then Core.wingAngleZ = minRad; Core.wingDirZ = 1 end
    end
end

return Wing
