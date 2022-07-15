local isDebug = getCore():getDebug()

local debugOptions = {
  enabled = true,
  enableFunctions = true,
  enableScope = true,
  enableProgress = true,
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

local enableFilesDebug = false
if isDebug and enableFilesDebug then

  function debugSandboxValue()
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

    print(SandboxVars)

    debugSandboxFunction("debugSandboxValue")
  end

  function debugSandboxFileValue()
    debugSandboxFunction("debugSandboxFileValue")
    local checkpoint = loadCheckpointOptions()
    
    for index,value in pairs(checkpoint) do
      
      local line = tostring(index) .. " " .. tostring(value)
      debugSandbox(line)
    
    end

    debugSandboxFunction("debugSandboxFileValue")
  end

  function debugCheckpointFileValue()
    debugSandboxFunction("debugCheckpointFileValue")
    
    local checkpoint = LoadSurvivorOptions()

    for index,value in pairs(checkpoint) do
      local line = tostring(index) .. " " .. tostring(value)
      debugSandbox(line)
    end

    debugSandboxFunction("debugCheckpointFileValue")
  end

  function debugMenuValue()
    debugSandboxFunction("debugMenuValue")

    for key,value in pairs(SuperSurvivorOptions) do
      
      debugSandbox("current menu config " .. key .. " : " .. tostring(value))
    
    end

    debugSandboxFunction("debugMenuValue")
  end
  
  Events.EveryTenMinutes.Add(debugSandboxValue)
  Events.EveryTenMinutes.Add(debugMenuValue)
  Events.EveryTenMinutes.Add(debugSandboxFileValue)
  Events.EveryTenMinutes.Add(debugCheckpointFileValue)
end