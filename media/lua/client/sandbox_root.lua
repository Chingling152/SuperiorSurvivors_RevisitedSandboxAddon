Events.OnGameStart.Add(configureSandboxOptions)

Events.OnMainMenuEnter.Add(rollbackToMenuOptions)

--- prevents start from being 
Events.LoadGridsquare.Remove(SuperSurvivorsLoadGridsquare)