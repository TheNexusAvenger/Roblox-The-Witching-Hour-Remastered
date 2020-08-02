--[[
TheNexusAvenger

Data for generating houses.
--]]

return {
    Colors = {
        WallColors = {
            BrickColor.new("Institutional white"),
            BrickColor.new("Medium blue"),
            BrickColor.new("Laurel green"),
            BrickColor.new("Medium stone grey"),
            BrickColor.new("Dark taupe"),
            BrickColor.new("Seashell"),
        },
        RoofColors = {
            BrickColor.new("Dark stone grey"),
            BrickColor.new("Linen"),
            BrickColor.new("Reddish brown"),
            BrickColor.new("Medium blue"),
        },
    },
    HouseAssemblies = {
        {
            HouseName = "MediumHouse",
            LawnDepth = 14,
            Components = {
                {
                    Group = "BaseLevels",
                    Options = {
                        "BaseLevel1",
                        "BaseLevel1",
                        "BaseLevel2",
                    },
                },
                {
                    Group = "Fronts",
                    Options = {
                        "Front1",
                    },
                },
                {
                    Group = "Roofs",
                    Options = {
                        "Roof1",
                        "Roof2",
                        "Roof3",
                        "Roof4",
                    },
                },
                {
                    Group = "SecondLevels",
                    Options = {
                        nil,
                        "SecondLevel1",
                    },
                },
            },
        },
        {
            HouseName = "SmallHouse",
            LawnDepth = 18,
            Components = {
                {
                    Group = "BaseLevels",
                    Options = {
                        "BaseLevel1",
                    },
                },
                {
                    Group = "Fronts",
                    Options = {
                        "Front1",
                        "Front1",
                        "Front2",
                    },
                },
                {
                    Group = "Roofs",
                    Options = {
                        "Roof1",
                        "Roof2",
                        "Roof3",
                        "Roof4",
                    },
                },
                {
                    Group = "SecondLevels",
                    Options = {
                        nil,
                        "SecondLevel1",
                    },
                },
                {
                    Group = "Additions",
                    Options = {
                        nil,
                        "Addition1",
                        "Addition2",
                    },
                },
            },
        },
    },
}