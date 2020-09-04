--[[
TheNexusAvenger and konlon15

Quests for the game.
Data from by konlon15.
--]]

return {
    --Shedletsky and Telamom
	["Mech Suit"] = {
		Description = "Collect 6 black iron ingots.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Black Iron Ingots",
			{
				Name = "Black Iron Ingot",
				Amount = 6
			},
		},
		Rewards = {
			XP = 200,
			Items = {
				{
					Name = "Quest Chest",
					Amount = 1
				}
			}
		}
	},
	["Find Telamom"] = {	--TODO: Currently not used, but not required; just helps game flow.
		Description = "Speak to Telamom",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Telamom"
		},
		Rewards = {
				
		}
	},
	["The 13 Swords"] = {
		Description = "Collect 13 Swords",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Swords",
			{
				Name = "Sword",
				Amount = 13
			},
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}
		}
	},
	["Action Figure Madness"] = {
		Description = "Collect 19 Action Figure Parts.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Action Figure Parts.",
			{
				Name = "Shedletsky Action Figure",
				Amount = 19
			},
		},
		Rewards = {
			Badge = "Shedletsky"
		}
	},
	["Fried Chicken Fracas"] = { 
		Description = "Collect ALL of the chicken.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Chicken Legs",
			{
				Name = "Chicken Leg",
				Amount = 61
			},
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 7
				}
			},
			XP = 650,
		}
	},
	
	--Builderman and Frazzled Clerk Jim
	["Fortifying Town Hall"] = {
		Description = "Collect old boards to help secure the Town Hall for attacks from the evil minions.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Old Boards",
			{
				Name = "Old Board",
				Amount = 4
			},
		},
		Rewards = {
			XP = 100,
			Items = {
				{
					Name = "Quest Chest",
					Amount = 1
				}
			}
		}
	},
	["Frazzled Jim"] = {
		Description = "Check up on Jim.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Frazzled Clerk Jim"
		},
		Rewards = {
			XP = 50
		}
	},
	["Turning on the Lights"] = {
		Description = "Kill evil monsters to get their friendly jack o lantern loot.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Friendly Jack o Lanterns",
			{
				Name = "Friendly Jack o Lantern",
				Amount = 8
			},
		},
		Rewards = {
			XP = 200,
			Badge = "Jack-o-lantern"
		}
	},
	["A quick remedy"] = {
		Description = "Ask ReeseMcBlox for a potion to help Jim calm down.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "ReeseMcBlox"
		},
		Rewards = {
			XP = 75
		}
	},
	["The beginning..."] = {
		Description = "Equip the full Skeleton Companion Costume.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Skeleton",
			DisplayName = "Skeleton Companion Set",
		},
		Rewards = {
			XP = 250,
			Badge = "Builderman"
		}
	},
	
	--ReeseMcBlox and AmazonianAstronaut
	["AmazonianAstronaut"] = {
		Description = "See if you can help AmazonianAstronaut.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "AmazonianAstronaut"
		},
		Rewards = {
			XP = 75,
		}
	},
	["A Mysterious Potion"] = {
		Description = "Vanquish purple spiders and take their intact fuzzy legs.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Purple Fuzzy Spider Legs",
			{
				Name = "Purple Fuzzy Spider Leg",
				Amount = 10
			},
		},
		Rewards = {
			XP = 300,
			Badge = "Miss Pumpkin"
		}
	},
	["Return to ReeseMcBlox"] = {
		Description = "Return to ReeseMcBlox and see if she needs more help.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "ReeseMcBlox"
		},
		Rewards = {
			--TODO: Possible XP reward.
		}
	},
	["Monsterous Candy Corn"] = {
		Description = "Slay monsters and take their candy corn, then return to ReeseMcBlox.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Candy Corn",
			{
				Name = "Candy Corn",
				Amount = 4
			},
		},
		Rewards = {
			XP = 200,
			Items = {
				{
					Name = "Quest Chest",
					Amount = 1
				}
			}
		}
	},
	["The Final Ingredient"] = {
		Description = "Kill evil minions and see if they have any Haunted pumpkin seeds, then return to ReeseMcBlox.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Haunted Pumpkin Seeds",
			{
				Name = "Haunted Pumpkin Seeds",
				Amount = 6
			},
		},
		Rewards = {
			XP = 250,
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}
		}
	},
	["Return To AmazonianAstronaut"] = {
		Description = "Go see what else AmazonianAstronaut needs.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "AmazonianAstronaut"
		},
		Rewards = {
			--TODO: Determine rewards.
		}
	},
	["A Costume For A Witch"] = {
		Description = "Equip the full Witch Companion Costume.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Witch",
			DisplayName = "Witch Companion Set",
		},
		Rewards = {
			XP = 500, --TODO: Guessed reward.
			Badge = "ReeseMcBlox"
		}
	},
	["Find BrightEyes"] = {
		Description = "Seek out BrightEyes.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "BrightEyes"
		},
		Rewards = {
			--TODO: Determine rewards.
		}
	},
	
	--BrightEyes
	["Spider Venom Moat"] = {
		Description = "Kill 17 Furry Purple Spiders.",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Furry Purple Spiders",
			{
				Name = "Furry Purple Spider",
				Amount = 17
			},
		},
		Rewards = {
			XP = 350,
			Items = {
				{
					Name = "Quest Chest",
					Amount = 1
				}
			}
		}
	},
	["Dance Ray Gun"] = {
		Description = "Speak to Darthskrill.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Darthskrill"
		},
		Rewards = {
			
		}
	},
	["BrightEyes BLOXikin"] = {
		Description = "Equip the full Vampire Companion Set.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Vampire",
			DisplayName = "Vampire Companion Set",
		},
		Rewards = {
			XP = 250,
			Badge = "BrightEyes"
		},
	},
	
	--Darthskrill AND CODEWRITER
	["Attack Of The SwampWolves"] = {
		Description = "Defeat 15 swamp wolves to help Darthskrill.",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Swamp Wolves",
			{
				Name = "Swamp Wolf",
				Amount = 15
			},
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}	
		}
	},
	
	["Missing CodeWriter"] = {
		Description = "Find CodeWriter, who disappeared in the swamp.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "CodeWriter"
		},
		Rewards = {
			
		}
	},
	
	["Spider Smash"] = {
		Description = "Kill Hairy Swamp Spiders for their fangs to keep Swamp Wolves away.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Hairy Swamp Spider Fangs",
			{
				Name = "Hairy Swamp Spider Fangs",
				Amount = 12
			},
		},
		Rewards = {
			XP = 100, --TODO: Guessed reward.
			Badge = "Spiderboy"
		}
	},

	["Mission Accomplished"] = {
		Description = "Tell Darthskrill the good news.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Darthskrill"
		},
		Rewards = {
			
		}
	},
	
	["Spread The Good 'Mews'"] = {
		Description = "Find Tarabyte and make sure she's safe from Bloxhilda.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Tarabyte"
		},
		Rewards = {
			
		}
	},
	
	["It's Not Easy Bein' Green"] = {
		Description = "Equip the full Swamp Monster Companion Costume to prove you are one with the swamp.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "SwampMonster",
			DisplayName = "SwampMonster Companion Set",
		},
		Rewards = {
			XP = 650, 
			Badge = "Darthskrill"
		}
	},
	
	--TARABYTE AND COATP0CKETNEEDLES
	
	["Disappearing Paintbrushes"] = {
		Description = "Find Tarabyte's missing paintbrushes.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Tarabyte's Magic Brushes",
			{
				Name = "Tarabyte's Magic Brush",
				Amount = 13 --TODO: 13 or 5?
			},
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 1
				}
			}
		}
	},
	
	["Not a Painter"] = {
		Description = "Talk to Tarabyte's friend Admin Coatp0cketninja.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Coatp0cketninja"
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 1
				}
			}
		}
	},
	
	["Cats Off To You"] = {
		Description = "Retrieve Coatp0cketninja's magic sewing needles",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Coatp0ckets Magic Needles",
			{
				Name = "Coatp0ckets Magic Needles",
				Amount = 15
			},
		},
		Rewards = {
			Badge = "Spidergirl"
		}
	},
	
	["Howling Good Time"] = {
		Description = "Find Tarabyte and investigate the strange noise.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Tarabyte"
		},
		Rewards = {
			--TODO: Determine rewards.
		}
	},
	
	["Paint The Town Red"] = {
		Description = "Find ChiefJustus and speak to him.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "ChiefJustus"
		},
		Rewards = {
			--TODO: Determine rewards.
		}
	},
	
	["Silent Isn't the Night"] = {
		Description = "Silence the wolves around Tarabyte's house.",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Howlers",
			{
				Name = "Howler",
				Amount = 17
			},
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 3
				}
			}
		}
	},
	
	["Fur'-ocious Fashion"] = {
		Description = "Equip the full Cat Companion Costume.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Cat",
			DisplayName = "Cat Companion Set",
		},
		Rewards = {
			XP = 850,
			Badge = "Tarabyte"
		}
	},
	
	--ChiefJustus AND Keith
	["A Needed Sacrifice"] = {
		Description = "Defeat friendly monsters for ChiefJustus.",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Monsters",
			{
				Name = "Monster",
				Amount = 20
			},
		},
		Rewards = {
			Badge = "Ooze Monster"
		}
	},
	["Helping Keith"] = {
		Description = "Find Keith and see what he needs help with.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Keith"
		},
		Rewards = {
			
		}
	},
	["Taking Candy From Monsters"] = {
		Description = "Defeat monsters and take their trick or treat bags, then return them to Keith",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Trick or Treat Bags",
			{
				Name = "Trick or Treat Bag",
				Amount = 13
			},
		},
		Rewards = {
			XP = 900,
			Badge = "Batgirl"
		}
	},
	["Help OstrichSized"] = {
		Description = "Find OstrichSized and see what he needs help with.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "OstrichSized"
		},
		Rewards = {
			
		}
	},
	["Demonic Powers"] = {
		Description = "Equip the full Devil Companion Costume.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Devil",
			DisplayName = "Devil Companion Set",
		},
		Rewards = {
			XP = 1050,
			Badge = "ChiefJustus"
		}
	},
	
	--OstrichSized, Creater Keeper, and Matt Dusek
	["Wise Wizard"] = {
		Description = "Speak to Matt Dusek",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Matt Dusek"
		},
		Rewards = {
			
		}
	},
	["Scare-ub Scuffle"] = {
		Description = "Defeat 10 scare-ubs to bring An00bus home",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Scare-ubs",
			{
				Name = "Scare-ub",
				Amount = 10
			},
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}
		}
	},
	["Squeeky Scarabs"] = {
		Description = "Gather 10 Squeeky Scarabs.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Squeeky Scarabs",
			{
				Name = "Squeeky Scarab",
				Amount = 13
			},
		},
		Rewards = {
			Badge = "Hallo-bot"
		}
	},
	["Mummy's Home"] = {
		Description = "Go back to OstrichSized",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "OstrichSized"
		},
		Rewards = {
			
		}
	},
	["Creeper Crunchies"] = {
		Description = "Retrieve some Creeper Crunchies.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Creeper Crunchies",
			{
				Name = "Creeper Crunchies",
				Amount = 5
			},
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 1
				}
			}
		}
	},
	["Jackal and Hide"] = {
		Description = "Retrieve some Creeper Crunchies from the wily Desert Jackal thieves",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Desert Jackals",
			{
				Name = "Desert Jackal",
				Amount = 20
			},
		},
		Rewards = {
			Badge = "Gargoyle"
		}
	},
	["Grab a Bite"] = {
		Description = "Find StickMasterLuke and see if Bloxhilda has affected him.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "StickMasterLuke"
		},
		Rewards = {
			
		}
	},
	["Tomb Sweet Tomb"] = {
		Description = "Go back to OstrichSized", --Fabricated.
		QuestType = "NPC",
		RequiredNPC = {
			Name = "OstrichSized"
		},
		Rewards = {
			
		}
	},
	["All Wrapped Up"] = {
		Description = "Dress your companion in the complete mummy costume.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Mummy",
			DisplayName = "Mummy Companion Set",
		},
		Rewards = {
			XP = 650,
			Badge = "OstrichSized"
		}
	},
	
	--StickMasterLuke AND Jmargh
	["Zombie Antidote"] = {
		Description = "Get 9 Zombie Antidotes to cure StickMasterLuke.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Zombie Antidotes",
			{
				Name = "Zombie Antidote",
				Amount = 9
			},
		},
		Rewards = {

			--TODO: Determine rewards. Check Jamiy Jamie's video.
		}
	},
	["A Good Distance"] = {
		Description = "Locate Jmargh's hiding place.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Jmargh"
		},
		Rewards = {
			
		}
	},
	["Preparing For ZA"] = {
		Description = "Get equiptment to fight the hordes of zombies.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Arrows",
			{
				Name = "Arrows",
				Amount = 12
			},
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}
		}
	},
	["One Zombie Down"] = {
		Description = "Kill 20 Zombies",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Zombies",
			{
				Name = "Zombie",
				Amount = 20
			},
		},
		Rewards = {
			Badge = "Yodalien"
		}
	},
	["Real Meaty"] = {
		Description = "Bring 16 T-bone Steaks to StickMasterLuke.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "T-bone Steaks",
			{
				Name = "T-bone Steak",
				Amount = 16
			},
		},
		Rewards = {
			Badge = "Scarecrow"
		}
	},
	["Not so Cured"] = {
		Description = "Equip the full Zombie Companion Set.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Zombie",
			DisplayName = "Zombie Companion Set",
		},
		Rewards = {
			XP = 0, --TODO: Determine reward.
			Badge = "StickMasterLuke"
		}
	},
	["Experiment Gone Wrong"] = {
		Description = "Talk to Fusroblox at his Castle.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Fusroblox"
		},
		Rewards = {
			
		}
	},
	
	--fusroblox and Totbl
	["Lost His Marbles"] = {
		Description = "Gather Fusroblox's marbles and return them to him.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Lost Marbles",
			{
				Name = "Lost Marbles",
				Amount = 12
			}
		},
		Rewards = {
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}
		}
	},
	["Clank Clank"] = {
		Description = "Fusroblox needs a few Knuts and Bolts to put himself back together.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Nuts and Bolts",
			{
				Name = "Nuts and Bolts",
				Amount = 15
			}
		},
		Rewards = {
			Badge = "Frankenstein's Bride"
		}
	},
	["Locating Totbl"] = {
		Description = "Find Totbl around the Castle.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Totbl"
		},
		Rewards = {
			--TODO: Determine rewards.
		}
	},
	["Clearing the Castle"] = {
		Description = "Rid the Castle Area of Blood Fangs",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Blood Fangs",
			{
				Name = "Blood Fang",
				Amount = 17
			},
		},
		Rewards = {
			Badge = "Headless Horseman",
			XP = 1500
		}
	},
	["Barely Human"] = { --TODO: Not given.
		Description = "Find OnlyTwentyCharacters at his hideout",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "OnlyTwentyCharacters"
		},
	},
	["BLOXing Time"] = { --TODO: Not used.
		Description = "Return to Fusroblox near the entrance of the castle.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "fusroblox"
		},
		Rewards = {
			--TODO: Determine rewards.
		}
	},
	
	--OnlyTwentyCharacters AND Dbapostle
	["Starting a Fire"] = {
		Description = "OnlyTwentyCharacters needs matches.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Matches",
			{
				Name = "Matches",
				Amount = 20
			},
		},
		Rewards = {
			Badge = "Raven",
			XP = 1400
		}
	},
	["I'm not food!"] = {
		Description = "Talk to Dbapostle behind OnlyTwentyCharacter's hideout.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Dbapostle"
		},
		Rewards = {
			--TODO: Determine rewards.
		}
	},
	["Dog Treats"] = {
		Description = "Dbapostle needs Dog Treats as back up for OnlyTwentyCharacters",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Dog Treats",
			{
				Name = "Dog Treats",
				Amount = 11
			},
		},
		Rewards = {
			Badge = "Kaiju",
			XP = 1400
		}
	},
	["Clean-up Crew"] = {
		Description = "Clear out the area around the Log Cabin of Ghost Spiders.",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Ghost Spiders",
			{
				Name = "Ghost Spider",
				Amount = 13
			},
		},
		Rewards = {
			XP = 1500,
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}
		}
	},
	["Is it safe?"] = {
		Description = "Take the chance and talk to OnlyTwentyCharacters again.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "OnlyTwentyCharacters"
		},
		Rewards = {
			XP = 450,
		}
	},
	["Friendly Solar Crane"] = {
		Description = "Locate everyone's favorite friendly ghost Solar Crane.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "SolarCrane"
		},
		Rewards = {
			XP = 500,
		}
	},
	["Wolfy"] = {
		Description = "Equip the full Werewolf Companion Set.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Werewolf",
			DisplayName = "Werewolf Companion Set",
		},
		Rewards = {
			Badge = "OnlyTwentyCharacters"
		}
	},
	
	--SolarCrane and Rraglyn
	["Bump In The Night"] = {
		Description = "Gather 10 Ghost Candles so the seance can begin",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Ghost Candles",
			{
				Name = "Ghost Candle",
				Amount = 10
			},
		},
		Rewards = {
			XP = 1650,
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}
		}
	},
	["Paw-inormal Activity"] = {
		Description = "Kill 20 Ghost Wolves",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Ghost Wolves",
			{
				Name = "Ghost Wolf",
				Amount = 20
			},
		},
		Rewards = {
			XP = 1950,
			Badge = "Spooky Owl"
		}
	},
	["Spooky Scholar"] = {
		Description = "DESC UNKNOWN! (meet raeglyn)",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Raeglyn",
		},
		Rewards = {
			--TODO: Determine rewards.
		}
	},
	["Spirit Box"] = {
		Description = "Gather the lost 13 pieces of Raeglyn's spirit box.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Spirit Box Pieces",
			{
				Name = "Spirit Box Piece",
				Amount = 13
			},
		},
		Rewards = {
			XP = 1600,
			Items = {
				{
					Name = "Quest Chest",
					Amount = 2
				}
			}
		}
	},
	["Ghost Warrior"] = {
		Description = "Kill 20 Ghosts to prove your stuff!",
		QuestType = "Monsters",
		RequiredMonsters = {
			DisplayName = "Ghosts",
			{
				Name = "Ghost",
				Amount = 20
			},
		},
		Rewards = {
			XP = 2000,
			Badge = "Batboy"
		}
	},
	["Ghost Go Home"] = {
		Description = "Head back to SolarCrane",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "SolarCrane"
		},
		Rewards = {
			XP = 500, --TODO: Guessed reward.
		}
	},
	["Cadaverous Pallor"] = {
		Description = "Equip the full Ghost Companion Set.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "Ghost",
			DisplayName = "Ghost Companion Set",
		},
		Rewards = {
			XP = 1000, --TODO: Guessed reward.
			Badge = "SolarCrane"
		}
	},
	["Skele-Troll"] = {
		Description = "Check on Sorcus",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Sorcus"
		},
		Rewards = {
			XP = 150, --TODO: Guessed reward.
		}
	},
	
	--Sorcus and Games
	["I C U"] = {
		Description = "Warp to Games and catch him off guard.",
		QuestType = "NPC",
		RequiredNPC = {
			Name = "Games"
		},
		Rewards = {
			XP = 75,
		}
	},	
	["Lens Flare"] = {
		Description = "Locate Game's lenses and bring it back to Sorcus.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Lens",
			{
				Name = "Lens",
				Amount = 13
			},
		},
		Rewards = {
			XP = 1337,
			Badge = "Invisible Man"
		}
	},
	["Clear Thy Soul"] = {
		Description = "Collect the grim reaper's lost souls and return them to him.",
		QuestType = "Items",
		RequiredItems = {
			DisplayName = "Souls",
			{
				Name = "Souls",
				Amount = 77
			},
		},
		Rewards = {
			XP = 7777,
			Badge = "Cthulhu"
		}
	},
	["End of Days"] = {
		Description = "Grim reap your companion or lose thy soul.",
		QuestType = "Dressup",
		RequiredSet = {
			Name = "GrimReaper",
			DisplayName = "Grim Reaper Companion Set",
		},
		Rewards = {
			XP = 9001,
			Badge = "Sorcus"
		}
	},
}