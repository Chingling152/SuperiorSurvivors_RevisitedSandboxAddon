require "0_Utilities/SuperSurvivorUtilities.lua"
require "4_UI/SuperSurvivorOptions.lua"
require "sandbox_debug.lua"

---@alias sandboxConfigs
---| "Spawn"
---| "Ai"
---| "Combat"
---| "Raiders"
---| "Misc"

local sandboxConfigs = {
  "Spawn", 
  "Ai", 
  "Combat", 
  "Raiders", 
  "Misc"
}
-- todo: remove it later
-- these cases will increase 1 in the value
local specialCases = {
  "AltSpawnPercent",
  "HostileSpawnRate", "MaxHostileSpawnRate", 
  "GunSpawnRate", "WepSpawnRate",
}

-- TODO: move to a commom place
local unchangedConfigs = {
  "SSHotkey1","SSHotkey2",
  "SSHotkey3","SSHotkey4",

  "DebugOptions","DebugOption_DebugSay","DebugOption_DebugSay_Distance", 
}

--- converts and sets the current value inside Survivor Options File (except unchangedConfigs)
---@param configName string name of the config in the Survivor Options mod
---@param optionValue string value to be changed
local function setConfigValue(configName, optionValue)

  local type = type(optionValue)
  local value;

  if type == "boolean" then
    if optionValue then
      value = 2 
    else
      value = 1
    end
  elseif has_value(specialCases,configName) then
    value = optionValue + 1
  elseif has_value(unchangedConfigs, configName) then
    value = SuperSurvivorOptions[configName]
  else 
    value = optionValue
  end 

  SuperSurvivorSetOption(configName, value)   

  debugSandbox("config " .. configName .. " changed to value : " .. tostring(value))
end

--- saves a config of a sandbox window
---@param configWindow sandboxConfigs sandbox window name
---@param config string sandbox field name 
local function saveConfig(configWindow,config)
  local sandboxConfig = config[1]
  local configName = config[2]
  
  if sandboxConfig == nil or configName == nil then
    debugSandbox("config not found")
    return
  end
  
  local optionValue = SandboxVars[configWindow][sandboxConfig]
  setConfigValue(configName, optionValue)   
end

--- saves every config of a sandbox window
---@param config sandboxConfigs sandbox window name
local function saveConfigs(config)
  debugSandboxFunction("changeSpawnConfigs")
  debugSandboxFunction(config)
  
  local configWindow = "SuperiorSurvivors" .. config
  local configs = SuperiorSurvivorsSandboxOptions[config]
  
  for index, config in ipairs(configs) do
    saveConfig(configWindow, config)
  end
  
  debugSandboxFunction(config)
  debugSandboxFunction("changeSpawnConfigs") 
end

--- Changes all fixed variables from SuperSurvivor
local function changeFixedOptionValues()
  local gameVersion = getCore():getGameVersion()
  local majorVersion = gameVersion:getMajor()
  local minorVersion = gameVersion:getMinor()

  local IsDamageBroken = ( majorVersion >= 41 and minorVersion> 50 and minorVersion < 53)
  local IsNpcDamageBroken = (majorVersion >= 41 and minorVersion >= 53)

  local getSandboxOption = function(section,position)
    return SuperiorSurvivorsSandboxOptions[section][position][2]
  end

  SuperSurvivorSpawnRate        = SuperSurvivorGetOptionValue(getSandboxOption("Spawn",1))
  AlternativeSpawning           = SuperSurvivorGetOptionValue(getSandboxOption("Spawn",2))
  AltSpawnPercent               = SuperSurvivorGetOptionValue(getSandboxOption("Spawn",3))
  AltSpawnGroupSize             = SuperSurvivorGetOptionValue(getSandboxOption("Spawn",4))
  ChanceToSpawnWithGun          = SuperSurvivorGetOptionValue(getSandboxOption("Spawn",5))
  ChanceToSpawnWithWep          = SuperSurvivorGetOptionValue(getSandboxOption("Spawn",6))
  ChanceToBeHostileNPC          = SuperSurvivorGetOptionValue(getSandboxOption("Spawn",7))
  NoPreSetSpawn                 = SuperSurvivorGetOptionValue(getSandboxOption("Spawn",10))
  
  SuperSurvivorBravery          = SuperSurvivorGetOptionValue(getSandboxOption("Ai",2))
  SurvivorHunger                = SuperSurvivorGetOptionValue(getSandboxOption("Ai",3))
  Option_FollowDistance         = SuperSurvivorGetOptionValue(getSandboxOption("Ai",4))
  SurvivorBases                 = SuperSurvivorGetOptionValue(getSandboxOption("Ai",5)) 
  SafeBase                      = SuperSurvivorGetOptionValue(getSandboxOption("Ai",6))
  SurvivorsFindWorkThemselves   = SuperSurvivorGetOptionValue(getSandboxOption("Ai",7))
  Option_Perception_Bonus       = SuperSurvivorGetOptionValue(getSandboxOption("Ai",8))
  
  Option_ForcePVP               = SuperSurvivorGetOptionValue(getSandboxOption("Combat",1))
  MaxChanceToBeHostileNPC       = SuperSurvivorGetOptionValue(getSandboxOption("Combat",2))
  SurvivorInfiniteAmmo          = SuperSurvivorGetOptionValue(getSandboxOption("Combat",3))

  Option_Display_Survivor_Names = SuperSurvivorGetOptionValue(getSandboxOption("Misc",1)) 
  Option_Display_Hostile_Color  = SuperSurvivorGetOptionValue(getSandboxOption("Misc",2)) 
  RoleplayMessage               = SuperSurvivorGetOptionValue(getSandboxOption("Misc",3)) 
  
  
  RaidsAtLeastEveryThisManyHours= SuperSurvivorGetOptionValue(getSandboxOption("Raiders",1)) 
  RaidsStartAfterThisManyHours  = SuperSurvivorGetOptionValue(getSandboxOption("Raiders",2))
  RaidChanceForEveryTenMinutes  = SuperSurvivorGetOptionValue(getSandboxOption("Raiders",3))
  if IsDamageBroken then
    MaxChanceToBeHostileNPC = 0
    RaidsStartAfterThisManyHours = 9999999
  end
end

--- Loads the current player square
local function loadPlayerGridSquare()
  debugSandboxFunction("loadPlayerGridSquare")
  
  local square = getPlayer():getSquare()
  SuperSurvivorsLoadGridsquare(square)

  debugSandboxFunction("loadPlayerGridSquare")
end

--- replace all options from the original mod and reactivate SuperSurvivorsLoadGridsquare 
function overrideOptionReset(playerId)
  debugSandboxFunction("overrideOptionReset")

  configureSandboxOptions()

  changeFixedOptionValues()  
  SSCreatePlayerHandle(playerId)
  
  loadPlayerGridSquare()
  changeFixedOptionValues()  
  
  Events.LoadGridsquare.Add(SuperSurvivorsLoadGridsquare)
  --Events.EveryTenMinutes.Add(SuperSurvivorsRaiderManager)
  
  debugSandboxFunction("overrideOptionReset")
end

--- configures all options from sandbox choices
function configureSandboxOptions()
  debugSandboxFunction("configureSandboxOptions")

  createCheckpoint()
  
  for index, config in ipairs(sandboxConfigs) do
    debugSandboxProgress("changing configs", index, #sandboxConfigs)
    saveConfigs(config)
  end

  --overrideOptionReset()

  --Events.OnGameStart.Remove(configureSandboxOptions)

  debugSandboxFunction("configureSandboxOptions")
end
