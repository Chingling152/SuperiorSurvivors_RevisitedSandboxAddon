local isDebug = getCore():getDebug()

local debugOptions = {
  enabled = false,
  enableFunctions = false,
  enableScope = false,
  enableProgress = false,
}

function debug(text)
  if isDebug then
    print(text)
  end
end

function debugSandbox(text)
  if debugOptions.enabled then
    debug(text)
  end
end

function debugSandboxFunction(text)
  if debugOptions.enableFunctions then
    debug(" ----- " .. text .. " ----- ")
  end
end

function debugSandboxScope(text)
  if debugOptions.enableScope then
    debug(" --- " .. text .. " --- ")
  end
end

function debugSandboxProgress(text,current,total)
  if debugOptions.enableProgress then
    debug(text .. " : " .. tostring(current) .. "/" .. tostring(total))
  end
end

-- lag warning
local enableFilesDebug = false
if isDebug and enableFilesDebug then

  local function debugSandboxValue()
    debugSandboxFunction("debugSandboxValue")

    local sandboxConfigs = {
      "Spawn", 
      "Ai", 
      "Combat", 
      "Raiders", 
      "Misc"
    }
    
    for _, config in ipairs(sandboxConfigs) do
      local configWindow = "SuperiorSurvivors" .. config
      local configs = SuperiorSurvivorsSandboxOptions[config]
      
      for index, config in ipairs(configs) do

        local sandboxConfig = config[1]
        local configName = config[2]
        
        if sandboxConfig == nil or configName == nil then
          debugSandbox("config not found")
          return
        end
        
        local optionValue = SandboxVars[configWindow][sandboxConfig]
        debugSandbox("current sandbox config " .. configName .. " : " .. tostring(optionValue))
      end
    end

    debugSandboxFunction("debugSandboxValue")
  end

  local function debugCurrentOptions()
    debugSandboxFunction("debugCurrentOptions")
		debugSandbox("Option_Perception_Bonus : " .. tostring(Option_Perception_Bonus))

		debugSandbox("Option_Display_Survivor_Names : " .. tostring(Option_Display_Survivor_Names))
		debugSandbox("Option_Display_Hostile_Color : " .. tostring(Option_Display_Hostile_Color))
		debugSandbox("Option_Panic_Distance : " .. tostring(Option_Panic_Distance))
		debugSandbox("Option_ForcePVP : " .. tostring(Option_ForcePVP))
		debugSandbox("Option_FollowDistance : " .. tostring(Option_FollowDistance))
		debugSandbox("SuperSurvivorBravery : " .. tostring(SuperSurvivorBravery))
		debugSandbox("RoleplayMessage : " .. tostring(RoleplayMessage))
		debugSandbox("AlternativeSpawning : " .. tostring(AlternativeSpawning))
		debugSandbox("AltSpawnGroupSize : " .. tostring(AltSpawnGroupSize))
		debugSandbox("AltSpawnPercent : " .. tostring(AltSpawnPercent))
		debugSandbox("NoPreSetSpawn : " .. tostring(NoPreSetSpawn))
		debugSandbox("DebugOptions : " .. tostring(DebugOptions))
		debugSandbox("DebugOption_DebugSay : " .. tostring(DebugOption_DebugSay))
		debugSandbox("DebugOption_DebugSay_Distance : " .. tostring(DebugOption_DebugSay_Distanc))
		debugSandbox("SafeBase : " .. tostring(SafeBase))
		debugSandbox("SurvivorBases : " .. tostring(SurvivorBases))
		debugSandbox("SuperSurvivorSpawnRate : " .. tostring(SuperSurvivorSpawnRate))
		debugSandbox("ChanceToSpawnWithGun : " .. tostring(ChanceToSpawnWithGun))
		debugSandbox("ChanceToSpawnWithWep : " .. tostring(ChanceToSpawnWithWep))
		debugSandbox("ChanceToBeHostileNPC : " .. tostring(ChanceToBeHostileNPC))
		debugSandbox("MaxChanceToBeHostileNPC : " .. tostring(MaxChanceToBeHostileNPC))
		debugSandbox("SurvivorInfiniteAmmo : " .. tostring(SurvivorInfiniteAmmo))
		debugSandbox("SurvivorHunger : " .. tostring(SurvivorHunger))
		debugSandbox("SurvivorsFindWorkThemselves : " .. tostring(SurvivorsFindWorkThemselves))
		debugSandbox("RaidsAtLeastEveryThisManyHours : " .. tostring(RaidsAtLeastEveryThisManyHou))
		debugSandbox("RaidsStartAfterThisManyHours : " .. tostring(RaidsStartAfterThisManyHours))
		debugSandbox("RaidChanceForEveryTenMinutes : " .. tostring(RaidChanceForEveryTenMinutes))

    debugSandboxFunction("debugCurrentOptions")
  end

  local function debugSandboxFileValue()
    debugSandboxFunction("debugSandboxFileValue")
    local checkpoint = loadCheckpointOptions()
    
    for index,value in pairs(checkpoint) do
      
      local line = tostring(index) .. " " .. tostring(value)
      debugSandbox(line)
    
    end

    debugSandboxFunction("debugSandboxFileValue")
  end

  local function debugCheckpointFileValue()
    debugSandboxFunction("debugCheckpointFileValue")
    
    local checkpoint = LoadSurvivorOptions()

    for index,value in pairs(checkpoint) do
      local line = tostring(index) .. " " .. tostring(value)
      debugSandbox(line)
    end

    debugSandboxFunction("debugCheckpointFileValue")
  end

  local function debugMenuValue()
    debugSandboxFunction("debugMenuValue")

    for key,value in pairs(SuperSurvivorOptions) do
      
      debugSandbox("current menu config " .. key .. " : " .. tostring(value))
    
    end

    debugSandboxFunction("debugMenuValue")
  end
  
  Events.EveryTenMinutes.Add(debugSandboxValue)
  Events.EveryTenMinutes.Add(debugMenuValue)
  Events.EveryTenMinutes.Add(debugCurrentOptions)
  Events.EveryTenMinutes.Add(debugSandboxFileValue)
  Events.EveryTenMinutes.Add(debugCheckpointFileValue)
end