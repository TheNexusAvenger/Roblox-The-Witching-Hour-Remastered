--[[
TheNexusAvenger

Attacks that are using in dungeons.
--]]

return {
    {
        Name = "Sword",
        Description = "A powerful melee attack!",
        Icon = 132783928,
        RequiredLevel = 0,
        EnergyPerUse = 0,
        ActivationKeys = {Enum.KeyCode.One},
        AttackCooldown = 0.5,
    },
    {
        Name = "Pumpkin",
        Description = "Throw a pumpkin at your foe and set them on fire!",
        Icon = 132786281,
        RequiredLevel = 0,
        EnergyPerUse = 40,
        ActivationKeys = {Enum.KeyCode.Two},
    },
    {
        Name = "[ Name Unknown ]",
        Description = "Blast an enemy with ice to slow them down!",
        Icon = 132790870,
        RequiredLevel = 5,
        EnergyPerUse = 15,
        ActivationKeys = {Enum.KeyCode.Three},
    },
    {
        Name = "Heal",
        Description = "Surround yourself with a healing aura!",
        Icon = 132791036,
        RequiredLevel = 10,
        EnergyPerUse = 40,
        ActivationKeys = {Enum.KeyCode.Four},
    },
    {
        Name = "Boost",
        Description = "Surround yourself in the might of Halloween, doubling damage and healing for 5 seconds!",
        Icon = 132791268,
        RequiredLevel = 15,
        EnergyPerUse = 30,
        ActivationKeys = {Enum.KeyCode.Five,Enum.KeyCode.Q},
    },
    {
        Name = "Bomb",
        Description = "Drop a trap that explodes on contact!",
        Icon = 132791426,
        RequiredLevel = 20,
        EnergyPerUse = 30,
        ActivationKeys = {Enum.KeyCode.Six,Enum.KeyCode.E},
    },
    {
        Name = "Spider Web",
        Description = "Drop a trap that roots enemies in place!",
        Icon = 132791553,
        RequiredLevel = 25,
        EnergyPerUse = 40,
        ActivationKeys = {Enum.KeyCode.Seven,Enum.KeyCode.R},
    },
    {
        Name = "Death Ball",
        Description = "[ Description unknown ]",
        Icon = 132791663,
        RequiredLevel = 30,
        EnergyPerUse = 100,
        ActivationKeys = {Enum.KeyCode.Eight,Enum.KeyCode.F},
    },
}