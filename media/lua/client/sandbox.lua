Events.OnMainMenuEnter.Add(rollbackToMenuOptions)
Events.OnCreatePlayer.Add(overrideOptionReset)
Events.OnGameStart.Add(configureSandboxOptions)-- TODO : improve code

--- prevents start from being restarted by removing old overriders
Events.LoadGridsquare.Remove(SuperSurvivorsLoadGridsquare)
Events.OnCreatePlayer.Remove(SSCreatePlayerHandle)