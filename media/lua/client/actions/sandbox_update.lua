require "0_Utilities/SuperSurvivorUtilities.lua"
require "4_UI/SuperSurvivorOptions.lua"
require "sandbox_debug.lua"

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

local unchangedConfigs = {
  "SSHotkey1","SSHotkey2",
  "SSHotkey3","SSHotkey4",

  "DebugOptions","DebugOption_DebugSay","DebugOption_DebugSay_Distance", 
}

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
  end -- TODO: deal with integers without break enums

  SuperSurvivorSetOption(configName, value)   

  debugSandbox("config " .. configName .. " changed to value : " .. tostring(value))
end

local function changeConfig(configWindow,config)
  local sandboxConfig = config[1]
  local configName = config[2]
  
  if sandboxConfig == nil or configName == nil then
    debugSandbox("config not found")
    return
  end
  
  debugSandboxScope(configName)

  local optionValue = SandboxVars[configWindow][sandboxConfig]
  setConfigValue(configName, optionValue)   
  
  debugSandboxScope(configName)
end

local function changeConfigs(config)
  debugSandboxFunction("changeSpawnConfigs")
  debugSandboxFunction(config)
  
  local configWindow = "SuperiorSurvivors" .. config
  local configs = SuperiorSurvivorsSandboxOptions[config]
  
  for index, config in ipairs(configs) do
    changeConfig(configWindow, config)
  end
  
  debugSandboxFunction(config)
  debugSandboxFunction("changeSpawnConfigs") 
end

function addSandboxOptions()
  -- local presets = getSandboxPresets()

  debugSandboxFunction("changeOptions")

  createCheckpoint()
  
  for index, config in ipairs(sandboxConfigs) do
    debugSandboxProgress("changing configs", index, #sandboxConfigs)
    changeConfigs(config)
  end

  debugSandboxFunction("changeOptions")

  Events.OnInitWorld.Remove(changeOptions)
end