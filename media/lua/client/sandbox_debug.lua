local debugOptions = {
  enabled = true,
  enableFunctions = true,
  enableScope = true,
  enableProgress = true,
}

function debugSandbox(text)
  if debugOptions.enabled then
    print(text)
  end
end

function debugSandboxFunction(text)
  if debugOptions.enableFunctions then
    print(" ----- " .. text .. " ----- ")
  end
end

function debugSandboxScope(text)
  if debugOptions.enableScope then
    print(" --- " .. text .. " --- ")
  end
end

function debugSandboxProgress(text,current,total)
  if debugOptions.enableProgress then
    print(text .. " : " .. tostring(current) .. "/" .. tostring(total))
  end
end