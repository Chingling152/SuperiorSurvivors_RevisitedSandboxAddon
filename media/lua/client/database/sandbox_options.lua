--- option proxy
-- sandbox value
-- superior survivors value

--todo: improve data structure 
-- (name, original_name, canBeChanged, specialCase)

SuperiorSurvivorsSandboxOptions = {
  ["Spawn"] = {
    {
      "SpawnRate",
      "SpawnRate" 
    },
    {
      "AltSpawnRate",
      "AltSpawn"
    },
    {
      "AltSpawnChance",
      "AltSpawnPercent"
    },
    {
      "AltSpawnRateGroupSize",
      "AltSpawnAmount"
    },
    {
      "GunChance",
      "GunSpawnRate"
    },
    {
      "MeleeChance",
      "WepSpawnRate"
    },
    {
      "HostileChance",
      "HostileSpawnRate"
    },
    {
      "SpawnWithWife",
      "WifeSpawn"
    },
    {
      "ReadyForBattle",
      "LockNLoad"
    },
    {
      "PresetSurvivors",
      "NoPreSetSpawn"
    },
  },
  ["Ai"]= {
    {
      "Friendliness",
      "SurvivorFriendliness"
    },
    {
      "Bravery",
      "Bravery"
    },
    {
      "NoHunger",
      "SurvivorHunger"
    },
    {
      "FollowGlobalRange",
      "Option_FollowDistance"
    },
    {
      "SurvivorBases",
      "SurvivorBases"
    },
    {
      "SafeBases",
      "SafeBase"
    },
    {
      "PerceptionBonus",
      "Option_Perception_Bonus"
    },
    {
      "FindWork",
      "FindWork"
    }
  },
  ["Combat"] = {
    {
      "ForcePvp",
      "Option_ForcePVP"
    },
    {
      "HostileMaxChance",
      "MaxHostileSpawnRate"
    },
    {
      "InfiniteAmmo",
      "InfinitAmmo"
    }
  },
  ["Raiders"] = {
    {
      "RaidersGuaranteed",
      "RaidersAtLeastHours"
    },
    {
      "RaidersAfter",
      "RaidersAfterHours"
    },
    {
      "RaidersChance",
      "RaidersChance"
    }
  },
  ["Misc"] = {
    {
      "DisplayName",
      "Option_Display_Survivor_Names"
    },
    {
      "DisplayHostile",
      "Option_Display_Hostile_Color"
    },
    {
      "RoleplayMessage",
      "RoleplayMessage"
    },
  }
}