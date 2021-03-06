require "0_Utilities/SuperSurvivorUtilities.lua"
require "4_UI/SuperSurvivorOptions.lua"
require "sandbox_debug.lua"

local checkpointFile = "SurvivorOptionsCheckpoint.lua"
local unchangedConfigs = { 
  "SSHotkey1","SSHotkey2",
  "SSHotkey3","SSHotkey4",

  "DebugOptions","DebugOption_DebugSay","DebugOption_DebugSay_Distance", 
}

local function doesOptionsCheckpointFileExist()
	local fileTable = {}
	local readFile = getFileReader(checkpointFile, false)

	if(readFile) then 
    return true
	else 
    return false 
  end
end

function loadCheckpointOptions()
  debugSandboxFunction("loadCheckpointOptions")
	
	local fileTable = {}
  
	if(not doesOptionsCheckpointFileExist()) then 
		debugSandbox("could not load options file")
    debugSandboxFunction("loadCheckpointOptions")
		return nil 
	end
  
  local readFile = getFileReader(checkpointFile, false)
	local scanLine = readFile:readLine()
  
	while scanLine do
		local values = {}
		for input in scanLine:gmatch("%S+") do 
			table.insert(values,input) 
		end
    
		if(fileTable[values[1]] == nil) then 
			fileTable[values[1]] = {} 
		end

		debugSandbox("loading config : " .. tostring(values[1]))

		if(has_value(unchangedConfigs,values[1]))then
			fileTable[values[1]] = tonumber(SuperSurvivorOptions[values[1]])
		else
			fileTable[values[1]] = tonumber(values[2])
		end
		
		scanLine = readFile:readLine()
    
		if not scanLine then 
      debugSandbox("end of file")
      break 
		end
	end
	readFile:close()

  debugSandboxFunction("loadCheckpointOptions")

	return fileTable
end

function rollbackToMenuOptions()
  debugSandboxFunction("rollback")
  
  local checkpoint = loadCheckpointOptions()
  if (checkpoint == nil) or (size(checkpoint) == 0) then
		debugSandbox("checkpoint file is empty or nil")
    debugSandboxFunction("rollback")
    return
  end
  
  SuperSurvivorOptions = checkpoint
  SaveSurvivorOptions()
  debugSandboxFunction("rollback")
end

function createCheckpoint()
  debugSandboxFunction("createCheckpoint")

  local writeFile = getFileWriter(checkpointFile, true, false)

	for index,value in pairs(SuperSurvivorOptions) do
    local line = tostring(index) .. " " .. tostring(value)
    debugSandbox("writing line : " .. line)
		writeFile:write(line .. "\r\n");
	end
	
	writeFile:close();

  debugSandboxFunction("createCheckpoint")
end
