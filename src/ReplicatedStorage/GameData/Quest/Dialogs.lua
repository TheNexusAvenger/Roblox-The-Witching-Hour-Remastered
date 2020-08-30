--[[
TheNexusAvenger and konlon15

Dialogs used in quests.
Data from by konlon15 with some modifications
by TheNexusAvenger, including flow fixes and
minor format changes for the remaster.
--]]

return {
    ["Builderman"] = {
		{
			Name = "Builderman_ALL_DONE",
			RequiredQuests = {
				{
					Name = "The beginning...",
					Status = "TurnedIn"
				}
			},
			Text = "We are always indebted to you, fellow Builder.",
			Alternatives = {
				{
					Text = "Thank you Builderman.",
					End = true
				}
			}
		},
		{
			Name = "Builderman_TheBeginning_START",
			RequiredQuests = {
				{
					Name = "Frazzled Jim",
					Status = "TurnedIn"
				},
				{
					Name = "The beginning...",
					Status = "NotUnlocked"
				}
			},
			Text = "To defeat the great evil that is Bloxhilda, we need to gather our resources. Across Bloxburg my fellow Admins are gathering their great powers.",
			Alternatives = {
				{
					Text = "That sounds epic!",
					Response = {
						Text = "We have created small representations of ourselves, which hold our great powers. They are known as BLOXikins. Each one of these will give abilities beyond which you are current capable of.",
						Alternatives = {
							{
								Text = "So how do I get one of these?",
								Response = {
									Text = "Each Admin will need unique items to help gather their power into the object. Will you help me finish mine?",
									Alternatives = {
										{
											Text = "Always ready to help. Anything for you Builderman!",
											Quest = "The beginning...",
											End = true
										},
										{
											Text = "I'm not that helpful...let me known when you are done.",
											End = true
										}
									}
								}
							},
							{
								Text = "A small figure that gives you powers? - No thanks.",
								End = true
							},
						}
					}
				},
				{
					Text = "You think you can defeat her? Ha!",
					End = true
				},
			}
		},
		{
			Name = "Builderman_TheBeginning_MID",
			RequiredQuests = {
				{
					Name = "The beginning...",
					Status = "Inventory"
				}
			},
			Text = "Your companion needs to be made of bones for this to work!",
			Alternatives = {
				{
					Text = "Bones? Well hmm...",
					End = true
				}
			}
		},
		{
			Name = "Builderman_TheBeginning_DONE",
			RequiredQuests = {
				{
					Name = "The beginning...",
					Status = "AllItems"
				}
			},
			TurnIn = "The beginning...",
			Text = "Whoa! Your companion looks nothing like it did earlier! Perfect Skeleton Costume, this is just what I needed as inspiration.",
			Alternatives = {
				{
					Text = "Why did you need a skeleton as reference?",
					Response = {
						Text = "We need to bring Halloween back; I had almost forgotten what something spooky looked like. I knew bones were involved though!",
						Alternatives = {
							{
								Text = "Of course! Using the spirit of Halloween to fight back!",
								Response = {
									Text = "Thanks so much for your help. With this may you bring back Halloween and banish Bloxhilda for eternity this time!",
									Alternatives = {
										{
											Text = "I will do my best Builderman.",
											End = true,
										},
										{
											Text = "I'd like to see her stay around.",
											End = true,
										}
									}
								}
							},
							{
								Text = "It's better not to remember spooky things...",
								End = true,
							}
						}
					}
				}
			}
		},
		{
			Name = "Builderman_FortifyingTownHall_DONE",
			RequiredQuests = {
				{
					Name = "Fortifying Town Hall",
					Status = "AllItems"
				}
			},
			Text = "This looks like just enough! Thanks for gathering these so quickly. We should be able to keep Town Hall safe now.",
			TurnIn = "Fortifying Town Hall",
			Alternatives = {
				{
					Text = "It was nothing! Always ready to help Builderman.",
					End = true
				}	
			}
		},
		{
			Name = "Builderman_FortifyingTownHall_MID",
			RequiredQuests = {
				{
					Name = "Fortifying Town Hall",
					Status = "Inventory"
				}
			},
			Text = "Please hurry! Her minions are attacking in larger groups! We need to secure the Town Hall!",
			Alternatives = {
				{
					Text = "I'm still looking! Just hold the fort down a bit longer!",
					End = true,
				}
			}
		},
		{
			Name = "Builderman_FrazzledJim_START",
			RequiredQuests = {
				{
					Name = "Fortifying Town Hall",
					Status = "TurnedIn"
				},
				{
					Name = "Frazzled Jim",
					Status = "NotUnlocked"
				}
			},
			Text = "Can you check on Jim? He's the head clerk here at the Town Hall. I'm worried he's having a hard time keeping it together.",
			Alternatives = {
				{
					Text = "Sure what do you need me to do?",
					Response = {
						Text = "Just go say hi. He's been a little on the edge since Bloxhilda appeared...",
						Alternatives = {
							{
								Text = "Got it, will do.",
								Quest = "Frazzled Jim",
								End = true
							},
							{
								Text = "What a scaredy cat. Like I'd help someone like that!",
								End = true
							}
						}
					}
				},
				{
					Text = "Jim? He's not an admin...",
					End = true
				}
			}
		},
		{
			Name = "Builderman_FrazzledJim_MID",
			RequiredQuests = {
				{
					Name = "Frazzled Jim",
					Status = "Inventory"
				}
			},
			Text = "Have you met Jim yet? He's right over there.",
			Alternatives = {
				{
					Text = "Sorry! I forgot. I will do that right now!",
					End = true
				}
			}
		},
		{
			Name = "Builderman_FortifyingTownHall_START",
			RequiredQuests = {
				{
					Name = "Fortifying Town Hall",
					Status = "NotUnlocked"
				}
			},
			Text = "Welcome fellow builder! Have you heard the terrible news? It's quite troubling. The streets are no longer safe, for the evil witch Bloxhilda has returned!",
			Alternatives = {
				{
					Text = "What do you mean she has returned?",
					Response = {
						Text = "A thousand years ago she came and stole Halloween. It took the city of Bloxburg seven years to recover. Now she has returned to take Halloween away forever! We need your help!",
						Alternatives = {
							{
								Text = "Sure thing! What can I do to help?",
								Response = {
									Text = "Town hall needs to be fortified. Can you find some boards?",
									Alternatives = {
										{
											Text = "On it!",
											Quest = "Fortifying Town Hall",
											End = true
										},
										{
											Text = "Too heavy!",
											End = true
										}
									}
								}
							},
							{
								Text = "Bah, who needs Halloween?",
								End = true
							},
						}
					}
				},
				{
					Text = "This is old news! Down with Bloxhilda!",
					End = true
				},
				{
					Text = "Bloxhilda forever! You shall not save this city Builderman!",
					End = true
				},
			}
		},
	},
	
	["Frazzled Clerk Jim"] = {
		{
			Name = "FrazzledClerkJim_FrazzledJim_CHECKUP",
			RequiredQuests = {
				{
					Name = "Frazzled Jim", 
					Status = "Inventory"
				},
			},
			Text = "Ahh..! Oh, it's just you...",
			TurnIn = "Frazzled Jim",
			Alternatives = {
				{
					Text = "Didn't mean to scare you. Builderman asked me to come by.",
					End  = true
				}
			}
		},
		{
			Name = "FrazzledClerkJim_TurningOnTheLights_START",	
			RequiredQuests = {
				{
					Name = "Frazzled Jim",
					Status = "TurnedIn",
				},
				{
					Name = "Turning on the Lights",
					Status = "NotUnlocked",
				},
			},
			Text = "It's so dark...so dark. She attacks when it's dark....Please help!",
			Alternatives = {
				{
					Text = "..you're afraid of the dark?",
					Response = {
						Text = "No! ...well lately...it's been hard not to....I mean...she attacks!!! Who wouldn't be scared of her!?!",
						Alternatives = {
							{
								Text = "How can I help you feel more safe here?",
								Response = {
									Text = "Can you steal back the jack-o-lanterns her minions took? Just a few should do...",
									Alternatives = {
										{
											Text = "Only a few?",
											Quest = "Turning on the Lights",
											End = true
										},
										{
											Text = "Flashlight.	 That's what you need, not a jack-o-lantern.",
											End = true
										},
									}
								}
							},
							{
								Text = "You're making this up.",
								End = true
							}
						}
					}
				},
				{
					Text = "Get a flashlight! It's not even that dark...",
					End = true
				}
			}
		},
			{
                Name = "FrazzledClerkJim_TurningOnTheLights_DONE",
                RequiredQuests = {
                    {
                        Name = "Turning on the Lights", 
                        Status = "AllItems"
                    }
                },
                Text = "You got them!?",
                TurnIn = "Turning on the Lights",
                Alternatives = {
				{
					Text = "Well yes, I always keep my promises!",
					End = true,
				}
			}
		},
		{
			Name = "FrazzledClerkJim_AQuickRemedy_START",
			RequiredQuests = {
				{
					Name = "Turning on the Lights",
					Status = "TurnedIn"
				},
				{
					Name = "A quick remedy",
					Status = "NotUnlocked"
				}
			},
			Text = "Have you met ReeseMcBlox? She is residing in the Witch Cottage. I've heard she makes a great potion to help with anxiety.",
			Alternatives = {
				{
					Text = "Sounds like just what you need.",
					Response = {
						Text = "Thank you so much! Just give her this to contain it.",
						Alternatives = {
							{
								Text = "< take the empty vial >",
								Quest = "A quick remedy",
								End = true
							},
							{
								Text = "<knock the vial on the ground> Oops!",
								End = true
							}
						}
					}
				},
				{
					Text = "No way, your quivering is hilarious!",
					End = true
				}
			}
		},
		{
			Name = "FrazzledClerkJim_AQuickRemedy_MID",
			RequiredQuests = {
				{
					Name = "A quick remedy",
					Status = "Inventory"
				}
			},
			Text = "ReeseMcBlox is located in the far South. Try getting to her as soon as possible!",
			Alternatives = {
				{
					Text = "Thanks for the advice.",
					End = true
				}
			}
		},
		{
			Name = "FrazzledClerkJim_ALL_DONE",
			RequiredQuests = {
				{
					Name = "A quick remedy",
					Status = "TurnedIn"
				}
			},
			Text = "You never know when Bloxhilda might strike again...",
			Alternatives = {
				{
					Text = "Is she that strong?",
					End = true
				}
			}
		},
		{
			Name = "FrazzledClerkJim_FALLBACK",
			RequiredQuests = nil,
			Text = "Ahh..! Oh, it's just you...",
			Alternatives = {
				{
					Text = "Didn't mean to scare you.",
					End = true
				}
			}
		},
	},
	
	["Sorcus"] = {
		{
			Name = "Sorcus_SkeleTroll_CHECKUP",
			RequiredQuests = {
				{
					Name = "Skele-Troll",
					Status = "Inventory"
				}
			},
			Text = "No.",
			TurnIn = "Skele-Troll",
			Alternatives = {
				{
					Text = "What is that supposed to mean?",
					End = true,
					Response = {
						Text = "No means, no."
					}
				}
			}
		},
		{
			Name = "Sorcus_ICU_START",
			RequiredQuests = {
				{
					Name = "Skele-Troll",
					Status = "TurnedIn",
				},
				{
					Name = "I C U",
					Status = "NotUnlocked",
				}
			},
			Text = "You know about Games?",
			Alternatives = {
				{
					Text = "Yeah I do!",
					End = true,
					Response = {
						Text = "[ We have no idea what Sorcus is supposed to say here. ]" --TODO: Determine message.
					}
				},
				{
					Text = "Who is that?",
					End = true,
					Response = {
						Text = "[ We have no idea what Sorcus is supposed to say here. ]" --TODO: Determine message.
					}
				},
				{
					Text = "Yeah the dude who made this game?",
					Response = {
						Text = "Yes, him. He is my long lost cousin.",
						Alternatives = {
							{
								Text = "Yeah, what about him?",
								End = true,
								Quest = "I C U",
								Response = {
									Text = "Go talk to him."
								}
							}
						}
					}
				},
			}
		},

		{
			Name = "Sorcus_LensFlare_DONE",
			RequiredQuests = {
				{
					Name = "Lens Flare",
					Status = "AllItems"
				}
			},
			Text = "Not only did you find my long lost cousin but you also completed what he asked of you, good.",
			TurnIn = "Lens Flare",
			Alternatives = {
				{
					Text = "AWESOME!",
					End = true,
				}	
			}
		},
		{
			Name = "Sorcus_ClearThySoul_START",
			RequiredQuests = {
				{
					Name = "Lens Flare",
					Status = "TurnedIn"
				},
				{
					Name = "Fried Chicken Fracas",
					Status = "TurnedIn"
				},
				{
					Name = "BrightEyes BLOXikin",
					Status = "TurnedIn"
				},
				{
					Name = "Wolfy",
					Status = "TurnedIn"
				},
				{
					Name = "Clear Thy Soul",
					Status = "NotUnlocked"
				},
			},
			Text = "Only the most worthy of people are chosen to help the Grim Reaper.",
			Alternatives = {
				{
					Text = "I don't know what that means.",
					Response = {
						Text = "It means you should complete all other quests before talking to me, child.",
						Alternatives = {
							{
								Text = "I have done them!",
								Response = {
									Text = "Oh, I see indeed you have.",
									Alternatives = {
										{
											Text = "So? Now give me the quest so I can collect your power to defeat Bloxhilda!",
											End = true
										},
										{
											Text = "Give it to me! Nao!",
											End = true
										},
										{
											Text = "OMG! You are so annoying.",
											Response = {
												Text = "Why, thank you adventurer.",
												Alternatives = {
													{
														Text = "Alright, now give me the quest before I get mad",
														End = true,
														Response = {
															Text = "Feed Me."
														}
													},
													{
														Text = "Give me quest pl0x",
														Response = {
															Text = "Interesting",
															Alternatives = {
																{
																	Text = "It's interesting right! Now give me!",
																	Quest = "Clear Thy Soul",
																	End = true,
																	Response = {
																		"Go collect 77 souls for me."
																	}
																}
															}
														}
													},
													{
														Text = "Dude I can't take this. I am leaving.",
														End = true,
														Response = {
															Text = "Thank you come again."
														}
													}
												}
											}
										},
										{
											Text = "I am done with this.",
											End = true
										}
									}
								}
							},
							{
								Text = "I don't need no quest from j00",
								End = true,
								Response = {
									Text = "Let Bloxhilda take you."
								}
							}
						}
					}
				},
				{
					Text = "I am not worthy enough",
					End = true
				}
			}
		},
		{
			Name = "Sorcus_ClearThySoul_DONE",
			RequiredQuests = {
				{
					Name = "Clear Thy Soul",
					Status = "AllItems"
				}
			},
			Text = "Congratulations. You have won nothing.",
			TurnIn = "Clear Thy Soul",
			Alternatives = {
				{
					Text = "You are welcome.",
					End = true,
					Response = {
						Text = "As I always am."
					}
				}
			}
		},
		{
			Name = "Sorcus_EndOfDays_START",
			RequiredQuests = {
				{
					Name = "Clear Thy Soul",
					Status = "TurnedIn"
				},
				{
					Name = "End of Days",
					Status = "NotUnlocked"
				}
			}, 
			Text = "With that you are prepared to finally accomplish what a mortal can only imagine.",
			Alternatives = {
				{
					Text = "Oooooo - what do I get ?",
					End = true,
				},
				{
					Text = "I hope it's the scythe.",
					Response = {
						Text = "Now, prepare yourself.",
						Alternatives = {
							{
								Text = "Gimme! Gimme! Gimme!",
								Quest = "End of Days",
								End = true,
								Response = {
									Text = "[ We have no idea what Sorcus is supposed to say here. ]" --TODO: Determine messages, move quest to correct spot.
								}
							}
						}
					}
				},
				{
					Text = "This is stupid, I am leaving.",
					End = true,
					Response = {
						Text = "Let the souls fight your path."
					}
				},
			}
		},
		{
			Name = "Sorcus_EndofDays_DONE",
			RequiredQuests = {
				{
					Name = "End of Days",
					Status = "AllItems"
				}
			},
			TurnIn = "End of Days",
			Text = "It seems like the mortal world has a chance afterall. I sense power overflowing from your companion. Now unite the power from all the BLOXikins to bring down Bloxhilda.",
			Alternatives = {
				{
					Text = "Man, I am done talking to you.",
					End = true,
				}	
			}
		},
		{
			Name = "Sorcus_NOTWORTHY",
			RequiredQuests = nil,
			Text = "You aren't worthy enough.",
			Alternatives = {
				{
					Text = "Oh, oh man. What a troll!",
					End = true,
				}
			}
		},
	},

	["Games"] = {
		{
			Name = "Games_ICU_CHECKUP",
			RequiredQuests = {
				{
					Name = "I C U", 
					Status = "Inventory"
				}
			},
			Text = "Congratulations! You found me!",
			TurnIn = "I C U",
			Alternatives = {
				{
					Text = "Yeah! Took some time! Sorcus gave me a clue.",
					Response = {
						Text = "He did? That's surprising.",
						Alternatives = {
							{
								Text = "Yeah, no.",
								End = true,
							}
						}
					}
				}
			}
		},
		{
			Name = "Games_LensFlare_START",
			RequiredQuests = {
				{
					Name = "I C U",
					Status = "TurnedIn"
				},
				{
					Name = "Lens Flare",
					Status = "NotUnlocked"
				}
			},
			Text = "Are you ready to do some questing for me?",
			Alternatives = {
				{
					Text = "I am ready, OYUS!",
					Response = {
						Text = "I use powerful lenses to derive power to make myself invisible",
						Alternatives = {
							{
								Text = "That is super awesome! You think you can share your secrets?",
								End = true,
								Response = {
									Text = "Not as I am right now. Sorry."
								}
							},
							{
								Text = "Oh man, that is awesome. Can you teach me?",
								Response = {
									Text = "I might be able to if you have the necessary mana. But currently I am missing my magical lenses. It seems Bloxhilda's beasts might have taken them from me.",
									Alternatives = {
										{
											Text = "Oh I can find them for you.",
											Response = {
												Text = "Can you do that? That's good! Please find them.",
												Alternatives = {
													{
														Text = "Wait a minute. You haven't given me the quest yet.",
														Response = {
															Text = "Yeah",
															Alternatives = {
																{
																	Text = "Are you going to give me the quest or not?",
																	End = true,
																	Response = {
																		Text = "Yeah"
																	}
																},
																{
																	Text = "Give me the quest!",
																	End = true,
																	Response = {
																		Text = "Yeah"
																	}
																},
																{
																	Text = "So give me the quest?",
																	End = true,
																	Quest = "Lens Flare",
																	Response = {
																		Text = "Okay",
																	}
																},
																{
																	Text = "Don't give me the quest.",
																	End = true,
																	Response = {
																		Text = "Yeah"
																	}
																},
																{
																	Text = "I don't want it",
																	End = true,
																	Response = {
																		Text = "Yeah"
																	}
																}
															}
														}
													},
													{
														Text = "Man, I am out of here.",
														End = true,
														Response = {
															Text = "Bye Bye"
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				},
				{
					Text = "I don't need invisibility! I am invincible.",
					End = true,
				}
			}
		},
		{
			Name = "Games_FALLBACK",	
			RequiredQuests = nil,
			Text = "Congratulations! You haven't found me.",
			Alternatives = {
				{
					Text = "What does that even mean???",
					End = true
				}
			}
		},
	},
	
	["Tarabyte"] = {
		{
			Name = "Tarabyte_SpreadTheGoodMews_CHECKUP",
			RequiredQuests = {
				{
					Name = "Spread The Good 'Mews'",
					Status = "Inventory"
				}
			},
			Text = "Oh no, oh no...what a cat-astrophe!",
			TurnIn = "Spread The Good 'Mews'",
			Alternatives = {
				{
					Text = "What's wrong Tarabyte? Darthskrill asked mt to check on you...",
					End = true,
				},
			}
		},
		{
			Name = "Tarabyte_DisappearingPaintbrushes_START",
			RequiredQuests = {
				{
					Name = "Disappearing Paintbrushes",
					Status = "NotUnlocked"
				},
				{
					Name = "Spread The Good 'Mews'",
					Status = "TurnedIn"	
				}
			},
			Text = "Aha! You have arrived, how purrrr'-fect! I've heard about you. The other Admins have told me how helpful you have been.",
			Alternatives = {
				{
					Text = "Well, only a little bit.",
					Response = {
						Text = "Don't be so modest! Would you be willing to do something for me as well?",
						Alternatives = {
							{
								Text = "Sure, taking Bloxhilda down one step at a time.",
								Response = {
									Text = "Great! All my magic paintbrushes disappeared last night, it's a 'meow'trage! I need them back ASAP.",
									Alternatives = {
										{
											Text = "What do they look like?",
											End = true,
											Quest = "Disappearing Paintbrushes"
										},
										{
											Text = "Maybe I took them! Haha!",
											End = true
										}
									}
								}
							},
							{
								Text = "No way!",
								End = true
							}
						}
					}
				},
				{
					Text = "I've only been spreading the word of Bloxhilda!",
					End = true
				}
			}
		},
		{
			Name = "Tarabyte_DisappearingPaintbrushes_MID",
			RequiredQuests = {
				{
					Name = "Disappearing Paintbrushes",
					Status = "Inventory"
				}
			},
			Text = "I suspect it was Bloxhilda's minions that took my brushes. They can't walk off on their own!",
			Alternatives = {
				{
					Text = "That makes sense...",
					End = true
				},
			}
		},
		{
			Name = "Tarabyte_DisappearingPaintbrushes_DONE",
			RequiredQuests = {
				{
					Name = "Disappearing Paintbrushes",
					Status = "AllItems"
				}
			},
			Text = "You found them!?",
			TurnIn = "Disappearing Paintbrushes",
			Alternatives = {
				{
					Text = "Yup, it was easy. Those minions are no match for me.",
					Response = {
						Text = "I can see that. Here is a reward for your help!",
						Alternatives = {
							{
								Text = "Thank you.",
								End = true,
							}
						}
					}
				},
			}
		},
		{
			Name = "Tarabyte_NotAPainter_START",
			RequiredQuests = {
				{
					Name = "Disappearing Paintbrushes", 
					Status = "TurnedIn"
				},
				{
					Name = "Not a Painter", 
					Status = "NotUnlocked"
				}
			},
			Text = "Next, you should meet my friend.",
			Alternatives = {
				{
					Text = "Your friend?",
					Response = {
						Text = "Yes, Admin Coatp0cketninja. She was visting today when Bloxhilda struck the city, maybe she saw something...",
						Alternatives = {
							{
								Text = "Alright, where is she?",
								End = true,
								Quest = "Not a Painter"
							},
							{
								Text = "Who cares!",
								End = true
							}
						}
					}
				},
				{
					Text = "No thanks.",
					End = true
				}
			}
		},
		{
			Name = "Tarabyte_HowlingGoodTime_CHECKUP",
			RequiredQuests = {
				{
					Name = "Howling Good Time", 
					Status = "Inventory"
				}
			},
			Text = "Did you find Coatp0cketninja?",
			TurnIn = "Howling Good Time",
			Alternatives = {
				{
					Text = "Yeah I found her",
					End = true,
					Response = {
						Text = "Oh 'purrr'-fect, I was worried about her, but now we have a new problem!"
					}
				},
			}
		},
		{
			Name = "Tarabyte_SilentIsntTheNight_START",
			RequiredQuests = {
				{
					Name = "Howling Good Time", 
					Status = "TurnedIn"
				},
				{
					Name = "Silent Isn't the Night",
					Status = "NotUnlocked"
				}
			},
			Text = "Do you hear that racket!?",
			Alternatives = {
				{
					Text = "Can do! I want my ears to stop bleeding too.",
					Response = {
						Text = "Those howlers won't stop! It's making all my cats 'hiss'terical! Can you get rid of the closest ones!?",
						Alternatives = {
							{
								Text = "Yeah it's pretty loud!",
								Quest = "Silent Isn't the Night",
								End = true
							},
							{
								Text = "Those are my brothers! I can't get \"rid\" of them!",
								End = true
							}
						}
					}
				},
				{
					Text = "The beautiful song of those ready to attack? Heh.",
					End = true
				}
			}
		},
		{
			Name = "Tarabyte_SilentIsntTheNight_DONE",
			RequiredQuests = {
				{
					Name = "Silent Isn't the Night",
					Status = "AllItems"
				}
			},
			Text = "Finally! Peace and quiet.",
			TurnIn = "Silent Isn't the Night",
			Alternatives = {
				{
					Text = "I know, it felt like there was no end to those things.",
					End = true,
				}
			}
		},
		{
			Name = "Tarabyte_FurFashion_START",
			RequiredQuests = {
				{
					Name = "Silent Isn't the Night",
					Status = "TurnedIn"
				},
				{
					Name = "Fur'-ocious Fashion", 
					Status = "NotUnlocked"
				}
			},
			Text = "The howlers are gone, but my cats are still 'furry' scared. Maybe if your companion had some 'cat'-ittude....",
			Alternatives = {
				{
					Text = "Cat-ittude? Like a costume?",
					Response = {
						Text = "Yes a costume! That sounds 'paw'-velous!",
						Alternatives = {
							{
								Text = "So what should I do?",
								Response = {
									Text = "If you complete the Companion Cat Costume, then I can help you.",
									Alternatives = {
										{
											Text = "Sure thing Tarabyte!",
											End = true,
											Quest = "Fur'-ocious Fashion"
										},
										{
											Text = "No way, I'm tired of these puns.",
											End = true
										}
									}
								}
							},
							{
								Text = "No way, I like my companion as it is!",
								End = true
							}
						}
					}				
				},
				{
					Text = "My companion is just fine, they'll just have to deal!",
					End = true
				}
			}
		},
		{
			Name = "Tarabyte_FurFashion_MID",
			RequiredQuests = {
				{
					Name = "Fur'-ocious Fashion", 
					Status = "Inventory"
				}
			},
			Text = "Your companion's looking 'purrrr'-ty, but...",
			Alternatives = {
				{
					Text = "I'm trying!",
					End = true
				},
			}
		},
		{
			Name = "Tarabyte_FurFashion_DONE",
			RequiredQuests = {
				{
					Name = "Fur'-ocious Fashion",
					Status = "AllItems"
				}
			},
			TurnIn = "Fur'-ocious Fashion"	,
			Text = "Fang'-tastic! Your companion is really rocking that look, with serious cat-ittude!",
			Alternatives = {
				{
					Text = "Yeah my companion is the cats meow now!",
					Response = {
						Text = "You've proven yourself a true furry friend",
						Alternatives = {
							{
								Text = "Of course! Thank you",
								Response = {
									Text = "Let ,me give you my BLOXikin. Take it and make sure to banish that hairball Bloxhilda!",
									Alternatives = {
										{
											Text = "I'll do my best Tarabyte!",
											End = true,
										},
										{
											Text = "I like her better than you! (she doesn't use puns...)",
											End = true
										}
									}
								}
							},
							{
								Text = "This costume is too silly",
								End = true
							}
						}
					}
				},
			}
		},
		{
			Name = "Tarabyte_FALLBACK",
			RequiredQuests = nil,
			Text = "Hello great Builder, have you ever done any Retexturing?",
			Alternatives = {
				{
					Text = "No....I'm not much of an artist.",
					End = true
				},
				{
					Text = "Yes! I love to retexture hats!",
					End = true
				}
			}
		},
	},
	
	["Coatp0cketninja"] = {
		{
			Name = "Coatp0cketninja_NotAPainter_CHECKUP",
			RequiredQuests = {
				{
					Name = "Not a Painter",
					Status = "Inventory"
				}
			},
			Text = "GGRRrrrrr!",
			TurnIn = "Not a Painter",
			Alternatives = {
				{
					Text = "Whoa! Uhh, Tarabyte sent me!",
					Response = {
						Text = "Oh she did? Hmmm...nice tah meet you.",
							Alternatives = {
								{
									Text = "Umm, not much.",
									End = true,
									Response = {
										Text = "Oh? Well then. What did she say?"
									}
								},
								{
									Text = "She said...stop staring at the trees!",
									End = true
								}
							}
					}
				},
				{
					Text = "...Weird.",
					End = true,
				}
			}
		},
		{
			Name = "Coatp0cketninja_CatsOffToYou_START",
			RequiredQuests = {
				{
					Name = "Not a Painter", 
					Status = "TurnedIn"
				},
				{
					Name = "Cats Off To You",
					Status = "NotUnlocked"
				}
			},
			Text = "I was viting Tarabyte and got up for amidnight snack when I saw it! Bloxhilda's spiders stole my sewing needles, now I can't make any hats for the ROBLOXians!",
			Alternatives = {
				{
					Text = "Spiders?! That's so mean of her!",
					Response = {
						Text = "I tried to find them but they're too 'fur'-ocious for me!",
						Alternatives = {
							{
								Text = "So how can I help?",
								Response = {
									Text = "Kill as many Rough-looking Spiders as you can, there were 15 sewing needles in all!",
									Alternatives = {
										{
											Text = "You got it!",
											End = true,
											Quest = "Cats Off To You"
										},
										{
											Text = "15? That's too much work...",
											End = true
										}
									}
								}
							},
							{
								Text = "Wow really? How weak are you?!",
								End = true
							}
						}
					}
				},
				{
					Text = "Who cares, I only care about gear.",
					End = true
				}
			}
		},
		{
			Name = "Coatp0cketninja_CatsOffToYou_DONE", 			
			RequiredQuests = {
				{
					Name = "Cats Off To You", 
					Status = "AllItems"
				}
			},
			Text = "Did you get them!?",
			TurnIn = "Cats Off To You",
			Alternatives = {
				{
					Text = "You bet!",
					End = true,
				}
			}
		},
		{
			Name = "Coatp0cketninja_HowlingGoodTime_START",
			RequiredQuests = {
				{
					Name = "Cats Off To You", 
					Status = "TurnedIn"
				},
				{
					Name = "Howling Good Time", 
					Status = "NotUnlocked"
				}
			},
			Text = "This is 'fang'-tastic! Now I can make hats again! But what's that's noise? Go check on Tarabyte right meow!",
			Alternatives = {
				{
					Text = "On my way!",
					End = true,
					Quest = "Howling Good Time"
				},
				{
					Text = "Do it yourself, weirdo.",
					End = true
				}
			}
		},
		{
			Name = "Coatp0cketninja_PaintTheTownRed_START",
			RequiredQuests = {
				{
					Name = "Cats Off To You",
					Status = "TurnedIn"
				},
				{
					Name = "Paint The Town Red", 
					Status = "NotUnlocked"
				}
			},
			Text = "It's purr-fectly peaceful here, but if Bloxhilda could reach me, then ChiefJustus is in danger!",
			Alternatives = {
				{
					Text = "What do you want me to do?",
					Response = {
						Text = "Head to his home, and see if he is safe 'purr'-chance?",
						Alternatives = {
							{
								Text = "I'm on my way!",
								Quest = "Paint The Town Red",
								End = true
							},
							{
								Text = "ChiefJustus? No way! But it might be better than all these puns...",
								End = true
							}
						}
					}
				},
				{
					Text = "That sounds too far away...",
					End = true
				},
			}
		},
		{
			Name = "Coatp0cketninja_PaintTheTownRed_MID", 			
			RequiredQuests = {
				{
					Name = "Paint The Town Red", 
					Status = "Inventory"
				}
			},
			Text = 	"Have you checked on ChiefJustus 'purrr'-chance?",
			Alternatives = {
				{
					Text = "Sorry! I forgot. I will do that right now!",
					End = true
				},
			}
		},
	},
	
	["StickMasterLuke"] = {
		{
			Name = "StickMasterLuke_GrabABite_CHECKUP",
			RequiredQuests = {
				{
					Name = "Grab a Bite",
					Status = "Inventory"
				}
			},
			Text = "Hello. You might not want to get to close.",
			Alternatives = {
				{
					Text = "Why? Is something wrong?",
					Response = {
						Text = "One of Bloxhilda's minions bit me..."
					},
					End = true
				}
			}
		},
		{
			--TODO: This dialog is fabricated.
			Name = "StickMasterLuke_ZombieAntidote_START",
			RequiredQuests = {
				{
					Name = "Zombie Antidote",
					Status = "NotUnlocked"
				},
				{
					Name = "Grab a Bite",
					Status = "TurnedIn"
				}
			},
			Text = "There's only one thing that can cure me..",
			Alternatives = {
				{
					Text = "And that is?",
					Response = {
						Text = "Zombie antidotes. I need nine of them, to be exact.",
						Alternatives = {
							{
								Text = "Alright! I'll get them for you right now!",
								End = true,
								Quest = "Zombie Antidote"
							},
							{
								Text = "Why nine?",
								Response = {
									Text = "Don't ask. Could you get them for me?",
									Alternatives = {
										{
											Text = "Definitely! Nine antidotes coming right up!",
											End = true,
											Quest = "Zombie Antidote"
										},
										{
											Text = "No.",
											End = true
										}
									}
								}
							},
							{
								Text = "Booring!",
								End = true
							}
						}
					}
				},
				{
					Text = "Nah, good luck with the zombie antics!",
					End = true
				}
			}
		},
		{
			Name = "StickMasterLuke_ZombieAntidote_MID",
			RequiredQuests = {
				{
					Name = "Zombie Antidote",
					Status = "Inventory"
				}
			},
			Text = "Did you find the antidotes?",
			Alternatives = {
				{
					Text = "Only a couple. We need more, to make sure it works!",
					End = true
				}
			}
		},
		{
			Name = "StickMasterLuke_ZombieAntidote_DONE",
			RequiredQuests = {
				{
					Name = "Zombie Antidote",
					Status = "AllItems"
				}
			},
			Text = "Thanks! This should be enough to make sure it works. If it's going to...",
			TurnIn = "Zombie Antidote",
			Alternatives = {
				{
					Text = "Don't worry! I'm sure you won't turn into a zombie.",
					End = true,
					Response = {
						Text = "Here's to hoping!"
					}
				}
			}
		},
		{
			Name = "StickMasterLuke_AGoodDistance_START",
			RequiredQuests = {
				{
					Name = "Zombie Antidote",
					Status = "TurnedIn"
				},
				{
					Name = "A Good Distance",
					Status = "NotUnlocked"
				}
			},
			Text = "Until we know if it works, you should probably steer clear of me.",
			Alternatives = {
				{
					Text = "I can go look for more Antidote!",
					Response = {
						Text = "No, it's best if you wait somewhere safe. Find jmargh, he is in a safe location.",
						Alternatives = {
							{
								Text = "Jmargh? Never heard of him.",
								Response = {
									Text = "He's new to the Games Team, I've been showing him the ropes.",
									Alternatives = {
										{
											Text = "New Admin? Cool!",
											End = true,
											Quest = "A Good Distance"
										},
										{
											Text = "There are too many Admins!",
											End = true
										},
									}
								}
							},
							{
								Text = "Nowhere is safe! Bloxhilda is everywhere, bwahaha!",
								End = true
							}
						}
					}
				}
			}
		},
		{
			Name = "StickMasterLuke_RealMeaty_CHECKUP",
			RequiredQuests = {
				{
					Name = "Real Meaty",
					Status = "AllItems"
				},
			},
			Text = "I thought I said stay away!",
			TurnIn = "Real Meaty",
			Alternatives = {
				{
					Text = "Jmargh said you might need these.",
					Response = {
						Text = "I'm not a Zombie yet! Why would I eat raw meat?",
						Alternatives = {
							{
								Text = "Then use it as a distraction from the real zombies.",
								End = true,
							}
						}
					}
				}
			}
		},
		{
			Name = "StickMasterLuke_NotSoCured_START",
			RequiredQuests = {
				{
					Name = "Real Meaty",
					Status = "TurnedIn"
				},
				{
					Name = "Not so Cured",
					Status = "NotUnlocked"
				}
			},
			Text = "Coinsidering how gross this stack of raw meat is, I think I'm safe from infection.",
			Alternatives = {
				{
					Text = "What to barbeque it? That sounds good right? Are you certain?",
					Response = {
						Text = "While that does sound tasty, I think we have more important matters to deal with.",
						Alternatives = {
							{
								Text = "You're talking about Bloxhilda right?",
								Response = {
									Text = "Yes. Now that I seem to be safe to be around. I need to work on creating that BLOXikin.",
									Alternatives = {
										{
											Text = "BLOXikin time? Finally!",
											Quest = "Not so Cured",
											End = true
										},
										{
											Text = "BLOXikins are useless.",
											End = true
										}
									}
								}
							},
							{
								Text = "Nothing is more important that a good BBQ.",
								End = true
							}
						}
					}
				},
				{
					Text = "Maybe zombies just like things alive...",
					End = true
				}
			}
		},
		{
			Name = "StickMasterLuke_NotSoCured_MID",
			RequiredQuests = {
				{
					Name = "Not so Cured",
					Status = "Inventory"
				},
			},
			Text = "Brains....guuuhhh. That's what your dog should be saying.",
			Alternatives = {
				{
					Text = "More brains?",
					Response = {
						Text = "It should be wanting that for dinner. It's not there yet."
					},
					End = true
				}
			}
		},
		{
			Name = "StickMasterLuke_FALLBACK",
			RequiredQuests = nil,
			Text = "Don't mess with zombies...the worry of turning into one just doesn't go away.",
			Alternatives = {
				{
					Text = "We will make sure to cure you and get rid of BLOXhilda for sure!",
					End = true
				}
			}
		},
	},
	
	["Jmargh"] = {
		{
			Name = "Jmargh_AGoodDistance_CHECKUP",
			RequiredQuests = {
				{
					Name = "A Good Distance",
					Status = "Inventory"
				}
			},
			Text = "Oh good you found me, argh!",
			TurnIn = "A Good Distance",
			Alternatives = {
				{
					Text = "...did you have to climb up here?",
					End = true,
					Response = {
						Text = "It's best to snipe zombies and not get ambushed, argh."
					}
				}
			}
		},
		{
			Name = "Jmargh_PreparingForZA_START",
			RequiredQuests = {
				{
					Name = "A Good Distance",
					Status = "TurnedIn"
				},
				{
					Name = "Preparing For ZA",
					Status = "NotUnlocked"
				}
			},
			Text = "We need to prepare for the Zombie Apocalypse, argh.",
			Alternatives = {
				{
					Text = "What do we need to do?",
					Response = {
						Text = "Weaponry is key, argh. The problem is Bloxhilda has raided all the nearby homes. We need to get as much back as possible, argh.",
						Alternatives = {
							{
								Text = "So what am I looking for?",
								End = true,
								Quest = "Preparing For ZA",
								Response = {
									Text = "Long range is better from up here. Grab as many bows as you can, argh."
								}
							},
							{
								Text = "I'm not going anywhere there are zombies roaming.",
								End = true
							}
						}
					}
				},
				{
					Text = "haha! Zombie Apocalypse! Yeah, right.",
					End = true
				}
			}
		},
		{
			Name = "Jmargh_PreparingForZA_DONE",
			RequiredQuests = {
				{
					Name = "Preparing For ZA",
					Status = "AllItems"
				}
			},
			Text = "What is this? Argh!",
			TurnIn = "Preparing For ZA",
			Alternatives = {
				{
					Text = "I could only find one bow. But here's a lot of ammo for it!",
					End = true,
					Response = {
						Text = "Well..I guess this works...argh.",
					}
				},
			}
		},
		{
			Name = "Jmargh_OneZombieDown_START",
			RequiredQuests = {
				{
					Name = "Preparing For ZA",
					Status = "TurnedIn"
				},
				{
					Name = "One Zombie Down",
					Status = "NotUnlocked"
				}
			},
			Text = "Now that we are armed, it's time to take down the masses of Zombies in the area, argh.",
			Alternatives = {
				{
					Text = "Great! I'm ready to clear out ALL the zombies!",
					Response = {
						Text = "For now I think 20 sounds good, argh.",
						Alternatives = {
							{
								Text = "20? No problem!",
								Quest = "One Zombie Down",
								End = true
							},
							{
								Text = "Why is it always so many!!",
								End = true
							}
						}
					}
				},
				{
					Text = "Ugh...more battles. See ya!",
					End = true
				}
			}
		},
		{
			Name = "Jmargh_OneZombieDown_DONE",
			RequiredQuests = {
				{
					Name = "One Zombie Down",
					Status = "AllItems"
				}
			},
			Text = "You are quite the zombie exterminater, argh!",
			TurnIn = "One Zombie Down",
			Alternatives = {
				{
					Text = "Maybe a bit.",
					End = true,
				},
			}
		},
		{
			Name = "Jmargh_RealMeaty_ExperimentGoneWrong_START",
			RequiredQuests = {
				{
					Name = "One Zombie Down",
					Status = "TurnedIn"
				},
				--Real Meaty is not checked since Experiemnt Gone Wrong needs to be checked, and checking Real Meaty can prevent it from being given.
				{
					Name = "Experiment Gone Wrong",
					Status = "NotUnlocked"
				}
			},
			Text = "Now that we have cleared the area of zombie activity, all we need to worry about is StickMasterLuke, argh.",
			Alternatives = {
				{
					Text = "Why are we worried about him?",
					Response = {
						Text = "Well, he may be a zombie down there waiting to eat some brains, argh.",
						Alternatives = {
							{
								Text = "Oh, I see the problem.",
								Response = {
									Text = "Yeah, let's get some bait. Throw the meat at him and we can make our escape, argh!",
									Alternatives = {
										{
											Text = "Sounds like a plan.",
											Quest = "Real Meaty",
											Response = {
												Text = "I also need you to run by Fusroblox's Castle when you are done, argh.",
												Alternatives = {
													{
														Text = "That shouldn't be a problem.",
														Quest = "Experiment Gone Wrong",
														End = true
													}
												}
											}
										},
										{
											Text = "Zombies only eat brains. Your plan is no good.",
											End = true
										}
									}
								}
							},
							{
								Text = "He's worried over nothing. StickMasterLuke can't be a zombie.",
								End = true
							}
						}
					}
				},
				{
					Text = "Let him be! Zombies will be zombies, nothing we can do.",
					End = true
				}
			}
		},
		{
			Name = "Jmargh_RealMeaty_MID",
			RequiredQuests = {
				{
					Name = "Real Meaty",
					Status = "Inventory"
				},
			},
			Text = "Did you get all that fake out meat and give it to StickMasterLuke? Argh.",
			Alternatives = {
				{
					Text = "Not yet.",
					End = true
				}
			}
		},
		{
			Name = "Jmargh_RealMeaty_MID",
			RequiredQuests = {
				{
					Name = "Real Meaty",
					Status = "AllItems"
				},
			},
			Text = "Did you get all that fake out meat and give it to StickMasterLuke? Argh.",
			Alternatives = {
				{
					Text = "Not yet.",
					End = true
				}
			}
		},
		{
			Name = "Jmargh_Fallback",
			RequiredQuests = nil,
			Text = "Living in the Zombie Apocalypse is a lot harder than I imagined it would be, argh.",
			Alternatives = {
				{
					Text = "Well yea...zombies...AND Bloxhilda.",
					End = true
				}
			}
		},
	},
	
	["fusroblox"] = {
		{
			Name = "fusroblox_ExperimentGoneWrong_CHECKUP",
			RequiredQuests = {
				{
					Name = "Experiment Gone Wrong",
					Status = "Inventory"
				}
			},
			Text = "Who are you!?",
			TurnIn = "Experiment Gone Wrong",
			Alternatives = {
				{
					Text = "I'm the new hero! You haven't heard of me?",
					Response = {
						Text = "No. I've been a bit preoccupied.",
						Alternatives = {
							{
								Text = "With what?",
								Response = {
									Text = " Nevermind that! What do you want?",
									Alternatives = {
										{
											Text = "Jmargh said to come here.",
											Response = {
												Text = "Oh. How's StickMasterLuke faring?",
												Alternatives = {
													{
														Text = "It's hard to tell...",
														End = true
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		},
		{
			Name = "fusroblox_LostMarbles_DONE",
			RequiredQuests = {
				{
					Name = "Lost His Marbles",
					Status = "AllItems"
				}
			},
			Text = "Oh wow! I feel so much better now. Almost like I'm whole.",
			TurnIn = "Lost His Marbles",
			Alternatives = {
				{
					Text = "That's great. You were a bit irritable before.",
					End = true,
					Response = {
						Text = "Sorry about that but its hard to describe the kind of terror you feel when something so important is missing."
					}
				}
			}
		},
		{
			Name = "fusroblox_ClankClank_START",
			RequiredQuests = {
				{
					Name = "Lost His Marbles",
					Status = "TurnedIn"
				},
				{
					Name = "Clank Clank",
					Status = "NotUnlocked"
				}
			},
			Text = "Now that I can think without feeling lost...do you think you could help me with one other thing?",
			Alternatives = {
				{
					Text = "Sure, what do you need?",
					Response = {
						Text = "It seems that something else is wrong after experiments were done on me.",
						Alternatives = {
							{
								Text = "What's wrong?",
								Response = {
									Text = "When I walk...there is this loud \"clank clank\" sound. Can you get some me some replacement parts?",
									Alternatives = {
										{
											Text = "Consider it done!",
											End = true,
											Quest = "Clank Clank"
										},
										{
											Text = "Everyone is so needy here!",
											End = true
										}
									}
								}
							},
							{
								Text = "You're a mess.",
								End = true
							}
						}
					}
				},
				{
					Text = "Could you be more needy?",
					End = true
				}
			}
		},
		{
			Name = "fusroblox_ClankClank_DONE",
			RequiredQuests = {
				{
					Name = "Clank Clank",
					Status = "AllItems"
				}
			},
			Text = "Great! These should do wonderfully.",
			TurnIn = "Clank Clank",
			Alternatives = {
				{
					Text = "It's the best I could find on such limited time.",
					End = true,
				}
			}
		},
		{
			Name = "fusroblox_LocatingTotbl_START",
			RequiredQuests = {
				{
					Name = "Clank Clank",
					Status = "TurnedIn"
				},
				{
					Name = "Locating Totbl",
					Status = "NotUnlocked"
				}
			},
			Text = "Find Totbl, he should be around here somewhere.",
			Alternatives = {
				{
					Text = "Why?",
					Response = {
						Text = "He will keep you busy while I fix myself up. Then we can get to that BLOXikin.",
						Alternatives = {
							{
								Text = "Fine...",
								Quest = "Locating Totbl",
								End = true
							},
							{
								Text = "BLOXikin NOW!",
								End = true
							}
						}
					}
				},
				{
					Text = "I'm not a messanger service!",
					End = true,
				}
			}
		},
		{
			Name = "fusroblox_FALLBACK",
			RequiredQuests = nil,
			Text = "Bloxburg is falling to Bloxhilda...and I'm falling apart...sigh.",
			Alternatives = {
				{
					Text = "Don't worry! All will be better soon!",
					End = true
				},
			}
		},
	},
	
	["Totbl"] = {
		{
			Name = "Totbl_LocatingTotbl_CHECKUP",
			RequiredQuests = {
				{
					Name = "Locating Totbl",
					Status = "Inventory"
				}
			},
			Text = "Hello there.",
			TurnIn = "Locating Totbl",
			Alternatives = {
				{
					Text = "Totbl? What kind of name is that.",
					End = true,
					Response = {
						Text = "Mine."
					}
				}
			}
		},
		{
			Name = "Totbl_ClearingTheCastle_START",
			RequiredQuests = {
				{
					Name = "Locating Totbl",
					Status = "TurnedIn"
				},
				{
					Name = "Clearing the Castle",
					Status = "NotUnlocked"
				}
			},
			Text = "So are you ready to help clear out Bloxhilda's minions around the Castle?",
			Alternatives = {
				{
					Text = "If I must.",
					Response = {
						Text = "Well you don't have to.",
						Alternatives = {
							{
								Text = "I'll do it..",
								End = true,
								Quest = "Clearing the Castle"
							},
							{
								Text = "Cool, cya!",
								End = true
							}
						}
					}
				},
				{
					Text = "What do I get for helping?",
					End = true,
					Response = {
						Text = "[ We have no idea what Totbl is supposed to say here. ]"
					}
				},
				{
					Text = "No thanks!",
					End = true
				}
			}
		},
		{
			Name = "Totbl_ClearingTheCastle_MID",
			RequiredQuests = {
				{
					Name = "Clearing the Castle",
					Status = "Inventory"
				}
			},
			Text = "Did you kill all of the Blood Fangs yet?",
			Alternatives = {
				{
					Text = "...you need me to kill too many! So no.",
					End = true,
				}
			}
		},
		{
			Name = "Totbl_ClearingTheCastle_DONE",
			RequiredQuests = {
				{
					Name = "Clearing the Castle",
					Status = "AllItems"
				}
			},
			TurnIn = "Clearing the Castle",
			Text = "Yes, Blood Fangs are gone!",
			Alternatives = {
				{
					Text = "Now where is that Sorcus clue!?!",
					Response = {
						Text = "Huh? Sorcus? Who is he...",
						Alternatives = {
							{
								Text = "You owe me Sorcus' location!",
								Response = {
									Text = "Fine. He's that way. <points>",
									Alternatives = {
										{
											Text = "<rolls eyes>",
											End = true,
										},
										{
											Text = "Ugh.",
											End = true,
										}
									}
								}
							},
							{
								Text = "<glare>",
								End = true
							}
						}
					}
				},
				{
					Text = "Yeah, now what?",
					End = true
				}
			}
		},
		{
			Name = "Totbl_FALLBACK",
			RequiredQuests = nil,
			Text = "Do you know Sorcus?",
			Alternatives = {
				{
					Text = "Yes.",
					Response = {
						Text = "Want to know a trick to getting his BLOXikin?",
						Alternatives = {
							{
								Text = "Of course!",
								End = true,
								Response = {
									Text = "Haha! I'd like to know too!"
								}
							},
							{
								Text = "No, I'd like to earn it as was designed.",
								End = true
							}
						}
					}
				}
			}
		}
	},
	
	["ReeseMcBlox"] = {
		{
			Name = "ReeseMcBlox_AmazonianAstronaut_START",
			RequiredQuests = {
				{
					Name = "A quick remedy",
					Status = {"Inventory","TurnedIn"},
				},
				{
					Name = "AmazonianAstronaut",
					Status = "NotUnlocked"
				}
			},
			Text = "You there, I have need of a special task.",
			TurnIn = "A quick remedy",
			Alternatives = {
				{
					Text = "What is this task that needs doing?",
					Response = {
						Text = "My assistant AmazonianAstronaut was supposed to come back some time ago to help me finish this potion, but I don't know where she is. Can you go find her?",
						Alternatives = {
							{
								Text = "Sure, that won't be a problem!",
								End = true,
								Quest = "AmazonianAstronaut"
							},
							{
								Text = "Why don't you hop on your broom and find her yourself?",
								End = true
							}
						}
					}
				},
				{
					Text = "I've got better things to do.",
					End = true
				}
			}
		},
		{
			Name = "ReeseMcBlox_MonsterousCandyCorn_START",
			RequiredQuests = {
				{
					Name = "Return to ReeseMcBlox",
					Status = {"Inventory","TurnedIn"},
				},
				{
					Name = "Monsterous Candy Corn",
					Status = "NotUnlocked"
				}
			},
			Text = "Now that I know AmazonianAstronaut is safe, you can help me with my special witches brew.",
			TurnIn = "Return to ReeseMcBlox",
			Alternatives = {
				{
					Text = "Sure thing!",
					Response = {
						Text = "You see, some monsters have taken all my candy corn, and I can't make my brew without candy corn.",
						Alternatives = {
							{
								Text = "Why would monsters take your candy corn?",
								Response = {
									Text = "Maybe they have a monsterous sweet tooth! So will you help me?",
									Alternatives = {
										{
											Text = "Yeah, we can't let those monsters get away with the candy corn!",
											End = true,
											Quest = "Monsterous Candy Corn"
										},
										{
											Text = "Couldn't you just go buy some?",
											End = true
										}
									}
								}
							},
							{
								Text = "Well, don't look at me!",
								End = true
							}
						}
					}
				},
				{
					Text = "I don't help witches, sorry!",
					End = true
				}
			}
		},
		{
			Name = "ReeseMcBlox_MonsterousCandyCorn_DONE",
			RequiredQuests = {
				{
					Name = "Monsterous Candy Corn",
					Status = "AllItems"
				}
			},
			TurnIn = "Monsterous Candy Corn",
			Text = "Ah you're back! And I see you didn't eat all the candy corn you found.",
			Alternatives = {
				{
					Text = "I was tempted, but it sounds like you really need it. Here you go.",
					End = true,
				},
				{
					Text = "Oh, that's a good idea. Maybe I will eat it all!",
					End = true
				}
			}
		},
		{
			Name = "ReeseMcBlox_TheFinalIngredient_START",
			RequiredQuests = {
				{
					Name = "Monsterous Candy Corn",
					Status = "TurnedIn"
				},
				{
					Name = "The Final Ingredient",
					Status = "NotUnlocked"
				}
			},
			Text = "My witches brew is almost complete! It only needs the final ingredient",
			Alternatives = {
				{
					Text = "What would that be?",
					Response = {
						Text = "I need many pumpkin seeds. But they have to be haunted!",
						Alternatives = {
							{
								Text = "How can pumpkin seeds be haunted?",
								Response = {
									Text = "They come from haunted pumpkins of course! So will you help me?",
									Alternatives = {
										{
											Text = "I still don't think pumpkin seeds can be haunted, but I'll do it!",
											Quest = "The Final Ingredient",
											End = true
										},
										{
											Text = "Sounds a little too spooky for me.",
											End = true
										}
									}
								}
							},
							{
								Text = "Haunted pumpkin seeds. That's just silly.",
								End = true
							}
						}
					}
				},
				{
					Text = "More ingredients? No thanks.",
					End = true
				}
			}
		},
		{
			Name = "ReeseMcBlox_TheFinalIngredient_DONE",
			RequiredQuests = {
				{
					Name = "The Final Ingredient", 
					Status = "AllItems"
				}
			},
			Text = "How is the pumpkin seed hunting going?",
			TurnIn = "The Final Ingredient",
			Alternatives = {
				{
					Text = "Great! I've got them all right here.",
					Response = {
						Text = "Excellent! Now my witches brew will be complete!",
						Alternatives = {
							{
								Text = "Glad I could help!",
								End = true
							}
						}
					}
				},
			}
		},
		{
			Name = "ReeseMcBlox_ReturnToAmazonianAstronaut_START",
			RequiredQuests = {
				{
					Name = "The Final Ingredient", 
					Status = "TurnedIn"
				},
				{
					Name = "Return To AmazonianAstronaut",
					Status = "NotUnlocked"
				}
			},
			Text = "AmazonianAstronaut has another task for you. Go talk to her again.",
			Alternatives = {
				{
					Text = "I'll go find her right away!",
					End = true,
					Quest = "Return To AmazonianAstronaut"
				},
				{
					Text = "Maybe later.",
					End = true
				}
			}
		},
		{
			Name = "ReeseMcBlox_ACostumeForAWitch_START", 			
			RequiredQuests = {
				{
					Name = "Return To AmazonianAstronaut",
					Status = "TurnedIn"
				},
				{
					Name = "A Costume For A Witch", 
					Status = "NotUnlocked"
				}
			},
			Text = "Now that my brew is complete, you need to obtain my BLOXikin!",
			Alternatives = {
				{
					Text = "What do I need to do to obtain such power!",
					Response = {
						Text = "You need to turn your companion into a witch!",
						Alternatives = {
							{
								Text = "Sound epic, I'll do it!",
								Quest = "A Costume For A Witch",
								End = true
							},
							{
								Text = "My companion doesn't want to be a witch!",
								End = true
							}
						}
					}
				},
			}
		},
		{
			Name = "ReeseMcBlox_ACostumeForAWitch_MID",
			RequiredQuests = {
				{
					Name = "A Costume For A Witch",
					Status = "Inventory"
				}
			},
			Text = "Your companion isn't looking very witch like.",
			Alternatives = {
				{
					Text = "I'm still working on it. I'll come back later.",
					End = true
				},
			}
		},
		{
			Name = "ReeseMcBlox_ACostumeForAWitch_DONE",
			RequiredQuests = {
				{
					Name = "A Costume For A Witch",
					Status = "AllItems"
				}
			},
			Text = "A fine witch companion if I've ever seen one!",
			TurnIn = "A Costume For A Witch",
			Alternatives = {
				{
					Text = "So do I get your BLOXikin power now?",
					Response = {
						Text = "Yes, just a little wave of my broom and a dash of my witches brew and there ya go! Awesome!",
						Alternatives = {
							{
								Text = "Now I'm one step closer to defeating Bloxhilda!",
								End = true
							}
						}
					}
				},
			}
		},
		{
			Name = "ReeseMcBlox_FALLBACK", 			
			RequiredQuests = nil,
			Text = "Bloxhilda doesn't stand a chance against the might of our Builders!",
			Alternatives = {
				{
					Text = "That's right! We will succeed!",
					End = true
				},
			}
		},
	},
	
	["AmazonianAstronaut"] = {
		{
			Name = "AmazonianAstronaut_AMysteriousPotion_START",
			RequiredQuests = {
				{
					Name = "AmazonianAstronaut",
					Status = {"Inventory","TurnedIn"}
				},
				{
					Name = "A Mysterious Potion",
					Status = "NotUnlocked"
				}
			},
			TurnIn = "AmazonianAstronaut",
			Text = "Since you came all this way to find me, how about you give me a hand with something?",
			Alternatives = {
				{
					Text = "Sure, I'll lend a hand.",
					Response = {
						Text = "Great! I need some spider legs. Not just any spider legs, purple fuzzy spider legs! Then I can create a potion of mysterious powers!",
						Alternatives = {
							{
								Text = "Oh good, I hate spiders! I'll gladly help you!",
								End = true,
								Quest = "A Mysterious Potion"
							},
							{
								Text = "Ew! No Thanks!",
								End = true
							}
						}
					}
				},
				{
					Text = "No, I think I'll go find something else to do.",
					End = true
				}
			}
		},
		{
			Name = "AmazonianAstronaut_AMysteriousPotion_MID", 
			RequiredQuests = {
				{
					Name = "A Mysterious Potion",
					Status = "Inventory"
				}
			},
			Text = "Those don't look like spider legs!",
			Alternatives = {
				{
					Text = "Sorry, I'll go get you some at once!",
					End = true
				},
			}
		},
		{
			Name = "AmazonianAstronaut_AMysteriousPotion_DONE",
			RequiredQuests = {
				{
					Name = "A Mysterious Potion",
					Status = "AllItems"
				}
			},
			TurnIn = "A Mysterious Potion",
			Text = "Thanks for the help! Oh I forgot, ReeseMcBlox was looking for me. Go tell her I'll catch up with her later, I need to conjure up this potion first!",
			Alternatives = {
				{
					Text = "Good luck with this fuzzy spider legs!",
					End = true,
					Quest = "Return to ReeseMcBlox"
				},
			}
		},
		{
			Name = "AmazonianAstronaut_ReturnToAmazonianAstronaut_CHECKUP",
			RequiredQuests = {
				{
					Name = "Return To AmazonianAstronaut",
					Status = "Inventory"
				}
			},
			TurnIn = "Return To AmazonianAstronaut",
			Text = "Hello again! ReeseMcBlox told me you'd be coming by again?",
			Alternatives = {
				{
					Text = "And here I am!",
					End = true,
				}
			}
		},
		{
			Name = "AmazonianAstronaut_FindBrightEyes_START",
			RequiredQuests = {
				{
					Name = "Return To AmazonianAstronaut",
					Status = "TurnedIn"
				},
				{
					Name = "Find BrightEyes",
					Status = "NotUnlocked"
				}
			},
			Text = "I need you to go see a friend of mine.",
			Alternatives = {
				{
					Text = "Who's that?",
					Response = {
						Text = "BrightEyes! She could really use your help.",
						Alternatives = {
							{
								Text = "I'm on it!",
								End = true,
								Quest = "Find BrightEyes"
							},
							{
								Text = "This task is too easy for me!",
								End = true
							}
						}
					}
				},
				{
					Text = "I think I've helped you out enough already.",
					End = true
				}
			}
		},
		{
			Name = "AmazonianAstronaut_FALLBACK",
			RequiredQuests = nil,
			Text = "Bloxhilda will never stand a chance against our united team!",
			Alternatives = {
				{
					Text = "That's the power of the Admins! (and me of course)",
					End = true,
				}	
			}
		},
	},
	
	["Shedletsky"] = {
		{
			Name = "Shedletsky_MechSuit_START",
			RequiredQuests = {
				{
					Name = "Mech Suit",
					Status = "NotUnlocked"
				}
			},
			Text = "So I've been asking around and it seems to me that none of the other admins know much about fighting witches. Lucky for them, I'm here.",
			Alternatives = {
				{
					Text = "So what's the plan?",
					Response = {
						Text = "Three beautiful words, my friend. Biograft. Exoskeleton. Mechsuit.",
						Alternatives = {
							{
								Text = "Those are pretty words. Tell me more.",
								Response = {
									Text = "I'm going to build one. Then I'm going to burn that witch with microwave pulse Laser cannons, I have all the laser parts, but I need material to build spell-resistant armor. Can you help?",
									Alternatives = {
										{
											Text = "Probably!",
											End = true,
											Quest = "Mech Suit"
										},
										{
											Text = "Not right now!",
											End = true
										},
									}
								}
							},
							{
								Text = "Your plan is bad and you should feel bad.",
								End = true
							}
						}
					}
				},
				{
					Text = "You? You're just standing around. I'm doing all the work around here?",
					Response = {
						Text = "Let be  finale of seem, seems to me.",
						Alternatives = {
							{
								Text = "The only emperor is the emperor of ice-cream?",
								Response = {
									Text = "Ah, a fellow student of the Art! Remember, the way through the world is more difficult to find than the way beyond it.",
									Alternatives = {
										{
											Text = "No, I was just exploring the chat tree. I'm done now.",
											End = true
										},
										{
											Text = "Well said, Telamon. Well said.",
											End = true
										}
									}
								}
							},
							{
								Text = "...",
								End = true
							}
						}
					}
				},
				{
					Text = "There's only so much of you one can take. Bye.",
					End = true
				}
			}
		},
		{
			Name = "Shedletsky_MechSuit_MID", 			
			RequiredQuests = {
				{
					Name = "Mech Suit", 
					Status = "Inventory"
				}
			},
			Text = "DUDE. Get me those black iron ingots, so I can melt them down to make magic-resistant armor for my eight-legged, fire-breathing, twin microwave laser blasting exoskeletal mechsuit! Do it! Do it",
			Alternatives = {
				{
					Text = "Sorry to be wasting your time, I'll go get them now.",
					End = true
				},
			}
		},
		{
			Name = "Shedletsky_MechSuit_DONE", 			
			RequiredQuests = {
				{
					Name = "Mech Suit", 
					Status = "AllItems"
				}
			},
			Text = "Alright! Black iron of pwnage. Time for me to get to the foundry.",
			TurnIn = "Mech Suit",
			Alternatives = {
				{
					Text = "Ok, but you have to promise that you'll lend me that mechsuit.",
					Response = {
						Text = "No promises!",
						Alternatives = {
							{
								Text = "No one like a mechsuit hog, mechsuit hog.",
								End = true
							},
						}
					}
				},
			}
		},
		--TODO: Add Find Telamom quest giver. It can be completd without it, but is unclear for new players.
		{
			Name = "Shedletsky_ActionFigureMadness_START",
			RequiredQuests = {
				{
					Name = "Mech Suit", 
					Status = "TurnedIn"
				},
				{
					Name = "Action Figure Madness",
					Status = "NotUnlocked"
				}
			},
			Text = "Remember those Shedletsky action figures I told you about before? Well they've gone missing. I suspect no-good gremlins stole them.",
			Alternatives = {
				{
					Text = "Missing?",
					Response = {
						Text = "Yeah. Missing and disassembled. I've found little plastic Shedletsky bits everywhere. It's quite horrifying actually.",
						Alternatives = {
							{
								Text = "I know, Halloween can be truly frightening sometimes.",
								Response = {
									Text = "Anyways, if you get my action figure bits back, I'll put them together and you can have one! Remember the amazing powers we spoke of earlier?",
									Alternatives = {
										{
											Text = "Oh man, I love powers. Deal.",
											End = true,
											Quest = "Action Figure Madness"
										},
										{
											Text = "I feel quite powerful enough now. Thanks anyways.",
											End = true
										}
									}
								}
							},
							{
								Text = "Reminds me of something I saw in SFOTH once.",
								End = true
							}
						}
					}
				},
				{
					Text = "Gremlins? Do you even lift?",
					End = true
				}
			}
		},
		{
			Name = "Shedletsky_ActionFigureMadness_DONE",
			RequiredQuests = {
				{
					Name = "Action Figure Madness",
					Status = "AllItems"
				}
			},
			Text = "MUAHAHAHAHAHAHA, FINALLY THE POWER IS MINE, THE WORLD WILL CRUMBLE AT MY FEET AND I WILL... oh. You're still here.",
			TurnIn = "Action Figure Madness",
			Alternatives = {
				{
					Text = "*Akward silence*",
					Response = {
						Text = "Well, you were very helpful. Here's your Shedletsky action figure. You keep it in mint condition now, you hear me?",
						Alternatives = {
							{
								Text = "If this doesn't give me amazing powers, I'm blaming you.",
								End = true,
								Response = {
									Text = "Everyone is too focused on blaming John for everything. Sometimes bad things happen, you know?",
								}
							},
							{
								Text = "...",
								End = true,
							}
						}
					}
				},
			}
		}
	},
	
	["Telamom"] = {
		{
			Name = "Telamom_The13Swords_START",
			RequiredQuests = {
				{
					Name = "The 13 Swords",
					Status = "NotUnlocked"
				}
			},
			Text = "Poor Telakins, I've actually lost some of his swords. He's so messy with them sometimes, it's hard to keep track of them all. If you gather them up for me, I'll give them to him.",
			Alternatives = {
				{
					Text = "Wouldn't it make more sense for me to keep the swords? There is an evil witch about, don't you know?",
					Response = {
						Text = "Well, to be honest, John has so many swords that if you were to find a bunch of them, I'm sure he wouldn't mind if you kept a couple for yourself.",
						Alternatives = {
							{
								Text = "Alright. Swords for everyone! I'll go find them!",
								End = true,
								Quest = "The 13 Swords"
							},
							{
								Text = "John can go find his own junk. Thanks.",
								End = true,
							}
						}
					}
				},
				{
					Text = "Ok, I'll take a look around",
					Quest = "The 13 Swords",
					End = true
				},
				{
					Text = "I'd like to help, but Telakins and I are both more about making messes than cleaning them up. You're getting old, grandma.",
					End = true
				}
			}
		},
		{
			Name = "Telamom_The13Swords_END",
			RequiredQuests = {
				{
					Name = "The 13 Swords",
					Status = "AllItems"
				}
			},
			TurnIn = "The 13 Swords",
			Text = "Cleaning up after John is hard work. Thanks for your efforts! Here's a little something extra for your trouble.",
			Alternatives = {
				{
					Text = "No problem.",
					End = true,
				},
			}
		},
		{
			Name = "Telamom_FriedChickenFraces_START",
			RequiredQuests = {
				{
					Name = "The 13 Swords",
					Status = "TurnedIn"
				},
				{
					Name = "Fried Chicken Fracas",
					Status = "NotUnlocked"
				}
			},
			Text = "Telakins is getting hungry for lunch! Can you help me feed him?",
			Alternatives = {
				{
					Text = "Uh... Like with a spoon?",
					Response = {
						Text = "Heavens no. Every day for lunch Telakins eats 61 fried chicken legs. I was wondering if you could go collect them for me.",
						Alternatives = {
							{
								Text = "SIXTY ONE? ARE YOU INSANE?!",
								End = true
							},
							{
								Text = "SIXTY ONE? ARE YOU INSANE?!",
								End = true
							},
							{
								Text = "SIXTY ONE? ARE YOU INSANE?!",
								End = true
							},
							{
								Text = "SIXTY ONE? ARE YOU INSANE?!",
								Response = {
									Text = "You can stop asking. I know it's crazy, but I love my Telakins so much. Fried chicken fuels his mad genius.",
									Alternatives = {
										{
											Text = "He *is* a great guy. I'll help.",
											Quest = "Fried Chicken Fracas",
											End = true
										},
										{
											Text = "I'll help, but I better get something awesome for this.",
											Quest = "Fried Chicken Fracas",
											End = true
										},
										{
											Text = "SIXTY ONE? ARE YOU INSANE?",
											End = true
										}
									}
								}
							}
						}
					}
				},
				{
					Text = "Nah I'm done with that guy.",
					End = true
				}
			}
		},
		{
			Name = "Telamom_FriedChickenFraces_DONE",
			RequiredQuests = {
				{
					Name = "Fried Chicken Fracas",
					Status = "AllItems"
				}
			},
			Text = "THANK YOU! I know it took you a while. You deserve a reward. Here's something nice. Now go enjoy Halloween!",
			TurnIn = "Fried Chicken Fracas",
			Alternatives = {
				{
					Text = "I hope Telakins doesn't get too fat to fit in his mechsuit.",
					Response = {
						Text = "Oh, don't worry about that. He has very fast metabolism.",
						Alternatives = {
							{
								Text = "There should be a potion for that.",
								End = true
							},
							{
								Text = "He's a fast talker too.",
								End = true
							}
						}
					}
				},
				{
					Text =  "No problem, ma'am!",
					End = true
				}
			}
		},
	},
	
	
	["BrightEyes"] = {
		{
			Name = "BrightEyes_FindBrightEyes_CHECKUP",
			RequiredQuests = {
				{
					Name = "Find BrightEyes",
					Status = "Inventory"
				}
			},
			TurnIn = "Find BrightEyes",
			Text = "Ah, AmazonianAstronaut said you might stop by.",
			Alternatives = {
				{
					Text = "Nice to meet you!",
					End = true,
				}
			}
		},
		{
			Name = "BrightEyes_SpiderVenomMoat_START",
			RequiredQuests = {
				{
					Name = "Spider Venom Moat",
					Status = "NotUnlocked"
				}
			},
			Text = "Bloxhilda wants to destroy everything in Bloxburg! I have to protect my house with spider venom for when the inevitable battle comes.",
			Alternatives = {
				{
					Text = "How will you protect your house?",
					Response = {
						Text = "I need to guard the house with a moat of spider venom the most deadly and hazardous venom comes from and furry purple spiders.",
						Alternatives = {
							{
								Text = "I happen to be an excellent spider killer!",
								Response = {
									Text = "Great can you kill 17 furry purple spiders and bring them back here?",
									Alternatives = {
										{
											Text = "Does Telamon like fried chicken? Of course!",
											Quest = "Spider Venom Moat",
											End = true
										},
										{
											Text = "Ewww....spiders!",
											End = true
										}
									}
								}
							},
							{
								Text = "Do I look like Spider: The Venom Hunter?",
								End = true
							}
						}
					}
				},
				
				{
					Text = "Bloxhilda is the bane of my existence!",
					End = true
					--TODO: Find this dialog
				},
				{
					Text = "Bloxhilda might be right to destroy your house, it's an eyesore.",
					End = true
				}
			}
		},
		{
			Name = "BrightEyes_SpiderVenomMoat_DONE",
			RequiredQuests = {
				{
					Name = "Spider Venom Moat",
					Status = "AllItems"
				}
			},
			TurnIn = "Spider Venom Moat",
			Text = "Yes! Victory is ours! Thanks for killing all those disgusting furry spiders. This should be enough venom to build a nice sized moat.",
			Alternatives = {
				{
					Text = "You're welcome! I'm a pro spider hunter now.",
					End = true,
				}
			}
		},
		{
			Name = "BrightEyes_DanceRayGun_START",
			RequiredQuests = {
				{
					Name = "Spider Venom Moat",
					Status = "TurnedIn"
				},
				{
					Name = "Dance Ray Gun",
					Status = "NotUnlocked"
				}
			},
			Text = "Have you met Darthskrill? He's a powerful warrior who lives alone in the swamp. I loaned him my dance ray gun and I think I'll need it back to help defeat Bloxhilda.",
			Alternatives = {
				{
					Text = "How will a dance ray gun help us defeat Bloxhilda?",
					Response = {
						Text = "True evil can only be driven out by dance... and weapons I guess. Will you go get it from Darthskrill in the swamp and bring it back to me?",
						Alternatives = {
							{
								Text = "I'll do it!",
								End = true,
								Quest = "Dance Ray Gun"
							},
							{
								Text = "Nah, I don't think this fight will come down to a dance off.",
								End = true
							}
						}
					}
				},
				{
					Text = "You should never loan people stuff before impending disasters. See ya!",
					End = true
				}
			}
		},
		{
			Name = "BrightEyes_DanceRayGun_MID",
			RequiredQuests = {
				{
					Name = "Dance Ray Gun",
					Status = "Inventory"
				}
			},
			Text = "Have you gotten my ray gun back yet?",
			Alternatives = {
				{
					Text = "Sorry! I've been too busy!",
					End = true
				},
			}
		},
		{
			Name = "BrightEyes_BrightEyesBloxikin_START",		
			RequiredQuests = {
				{
					Name = "Dance Ray Gun",
					Status = "TurnedIn"
				},
				{
					Name = "BrightEyes BLOXikin",
					Status = "NotUnlocked"
				}
			},
			Text = "All of us admins are putting together some BLOXikins to help Bloxhilda. I'm sure that Builderman already told you about this. Will you help me build mine?",
			Alternatives = {
				{
					Text = "I'm an excellent builder- I'd be happy to help.",
					Response = {
						Text = "All of us admins are putting together some BLOXikins to help Bloxhilda. I'm sure that Builderman already told you about this. Will you help me build mine?",
						Alternatives = {
							{
								Text = "I'll do it!",
								End = true,
								Quest = "BrightEyes BLOXikin"
							},
							{
								Text = "Meh I'm too sleepy to look for stuff now.",
								End = true
							},
							{
								Text = "I'm tired of doing this. Build that BLOXikin on your own.",
								End = true
							}
						}
					}
				},
			}
		},
		{
			Name = "BrightEyes_BrightEyesBloxikin_DONE",
			RequiredQuests = {
				{
					Name = "BrightEyes BLOXikin",
					Status = "AllItems"
				}
			},
			Text = "Your companion sucks. Get it? Because he's a real vampire now?",
			TurnIn = "BrightEyes BLOXikin",
			Alternatives = {
				{
					Text = "Do you ever get sick of corny jokes?",
					Response = {
						Text = "Never! They're my favorite. Anyhow - thanks a million!",
						Alternatives = {
							{
								Text = "Of course! Residents of Bloxburg have to work together to achieve victory!",
								Response = {
									Text = "This will help you defeat Bloxhilda for sure.",
									Alternatives = {
										{
											Text = "I bet it will. It is my lucky day after all.",
											End = true,
										},
										{
											Text = "Will it really? Looks like a silly Halloween toy to me...",
											End = true,
										}
									}
								}
							},
							{
								Text = "Whatever....",
								End = true
							}
						}
					}
				},
				{
					Text = "I don't get it....",
					End = true
				},
			}
		},
		{
			Name = "BrightEyes_ALL_DONE",
			RequiredQuests = {
				{
					Name = "BrightEyes BLOXikin",
					Status = "TurnedIn"
				}
			},
			Text = "Today's your lucky day I just know it!",
			Alternatives = {
				{
					Text = "You know, I was feeling kind of lucky today...",
					End = true
				},
			}
		},
	},
	
	["ChiefJustus"] = {
		{
			Name = "ChiefJustus_PaintTheTownRed_CHECKUP",
			RequiredQuests = {
				{
					Name = "Paint The Town Red",
					Status = "Inventory"
				}
			},
			Text = "Who dares enter my lair!",
			TurnIn = "Paint The Town Red",
			Alternatives = {
				{
					Text = "I'm trying to defeat Bloxhilda, and I need your BLOXikin ChiefJustus.",
					Response = {
						Text = "Ah, a worthy cause, but it will cost you your soul!",
						Alternatives = {
							{
								Text = "Can't I do something else for you beside giving you my soul?",
								End = true,
							},
						}
					}
				},
			}
		},
		{
			Name = "ChiefJustus_ANeededSacrifice_START",
			RequiredQuests = {
				{
					Name = "Paint The Town Red",
					Status = "TurnedIn"
				},
				{
					Name = "A Needed Sacrifice", 
					Status = "NotUnlocked"
				}
			},
			Text = "Now that you mention it, there is something you can do. There's some monsters that don't view me as their demon lord. Go teach them a lesson for me.",
			Alternatives = {
				{
					Text = "Defeated monsters coming right up!",
					Quest = "A Needed Sacrifice",
					End = true
				},
				{
					Text = "Can't you do it yourself?",
					End = true,
				},
			}
		},
		
		{
			Name = "ChiefJustus_ANeededSacrifice_MID",
			RequiredQuests = {
				{
					Name = "A Needed Sacrifice", 
					Status = "Inventory"
				}
			},
			Text = "Have you defeated those monsters yet?",
			Alternatives = {
				{
					Text = "I'm still working on it ChiefJustus.",
					End = true
				},
			}
		},
		{
			Name = "ChiefJustus_ANeededSacrifice_DONE",
			RequiredQuests = {
				{
					Name = "A Needed Sacrifice", 
					Status = "AllItems"
				}
			},
			TurnIn = "A Needed Sacrifice",
			Text = "I see you have slain the monsters, A worthy sacrifice if I do say so.",
			Alternatives = {
				{
					Text = "Just doing what needs to be done to defeat Bloxhilda.",
					End = true
				},
			}
		},
		{
			Name = "ChiefJustus_HelpingKeith_START", 			
			RequiredQuests = {
				{
					Name = "A Needed Sacrifice", 
					Status = "TurnedIn"
				},
				{
					Name = "Helping Keith",
					Status = "NotUnlocked"
				}
			},
			Text = "Before I give you my BLOXikin, there is someone you must meet. Keith, my faithful helper.",
			Alternatives = {
				{
					Text = "I shall find him and lend him a hand!",
					Quest = "Helping Keith",
					End = true
				},
				{
					Text = "I've got some other things to take care of.",
					End = true
				}
			}
		},
		{
			Name = "ChiefJustus_DemonicPowers_START",
			RequiredQuests = {
				{
					Name = "Helping Keith", 
					Status = "TurnedIn"
				},
				{
					Name = "Demonic Powers",
					Status = "NotUnlocked"
				}
			},
			Text = "I am almost ready to give you my BLOXikin, but before I bestow you with my power, you must do one more thing.",
			Alternatives = {
				{
					Text = "Just tell me what needs to be done ChiefJustus",
					Response = {
						Text = "Your companion isn't demon like. You need to change that. Find a demon costume for your companion and dress it up!",
						Alternatives = {
							{
								Text = "My companion will be the best looking demon ever!",
								End = true,
								Quest = "Demonic Powers"
							},
							{
								Text = "I don't want to dress my companion up like a demon.",
								End = true
							}
						}
					}
				},
				{
					Text = "I'm done doing task for you.",
					End = true
				}
			}
		},
		{
			Name = "ChiefJustus_DemonicPowers_MID",
			RequiredQuests = {
				{
					Name = "Demonic Powers",
					Status = "Inventory"
				}
			},
			Text = "How is your demon companion costume coming along?",
			Alternatives = {
				{
					Text = "I'm still gathering the pieces.",
					End = true
				},
			}
		},
		{
			Name = "ChiefJustus_DemonicPowers_DONE",
			RequiredQuests = {
				{
					Name = "Demonic Powers",
					Status = "AllItems"
				}
			},
			TurnIn = "Demonic Powers",
			Text = "Your companion has the look of a true demon! Now, I will recite the ancient ritual and give you the power of my demon BLOXikin.",
			Alternatives = {
				{
					Text = "Thanks ChiefJustus! Bloxhilda is one step closer to being defeated with your help!",
					End = true
				},
			}
		},
	},
	
	["Keith"] = {
		{
			Name = "Keith_HelpingKeith_CHECKUP",
			RequiredQuests = {
				{
					Name = "Helping Keith", 
					Status = "Inventory"
				}
			},
			Text = "Who is this that dares to approach me?",
			TurnIn = "Helping Keith",
			Alternatives = {
				{
					Text = "ChiefJustus said you needed some help.",
					End = true,
				},
			}
		},
		{
			Name = "Keith_TakingCandyFromMonsters_START",
			RequiredQuests = {
				{
					Name = "Helping Keith", 
					Status = "TurnedIn"
				},
				{
					Name = "Taking Candy From Monsters", 
					Status = "NotUnlocked"
				}
			},
			Text = "You there, I have a fiendish task for you if you're up for it!",
			Alternatives = {
				{
					Text = "Fiendish huh? Sounds like fun! What do you need.",
					Response = {
						Text = "ChiefJustus won't let me go trick or treating, and I see all those monsters with their bags of candy. I want you to defeat them, and bring me their bags of candy.",
						Alternatives = {
							{
								Text = "Of course Keith. I will bring you delicious candy!",
								Quest = "Taking Candy From Monsters",
								End = true
							},
							{
								Text = "I can't do that, that's mean!",
								End = true
							}
						}
					}
				},
				{
					Text = "I've got some other things to take care of.",
					End = true
				}
			}
		},
		{
			Name = "Keith_TakingCandyFromMonsters_DONE",
			RequiredQuests = {
				{
					Name = "Taking Candy From Monsters", 
					Status = "AllItems"
				}
			},
			Text = "You're back, do you have my candy?",
			TurnIn = "Taking Candy From Monsters",
			Alternatives = {
				{
					Text = "Here you are Keith, plenty of candy to last you a while!",
					End = true,
				},
			}
		},
		{
			Name = "Keith_HelpOstrichSized_START",
			RequiredQuests = {
				{
					Name = "Taking Candy From Monsters", 
					Status = "TurnedIn"
				},
				{
					Name = "Help OstrichSized",
					Status = "NotUnlocked"
				}
			},
			Text = "Thanks for the candy! I don't need anything else right now, but you should go find OstrichSized, he needs some help!",
			Alternatives = {
				{
					Text = "Sounds good Keith!",
					End = true,
					Quest = "Help OstrichSized"
				},
			}
		},
	},
	
	["OstrichSized"] = {
		{
			Name = "OstrichSized_HelpOstrichSized_CHECKUP",
			RequiredQuests = {
				{
					Name = "Help OstrichSized",
					Status = "Inventory"
				}
			},
			Text = "Hello Builder! Welcome to my marvelous pyramid! AH, but I'm not feeling too marvelous right now..",
			TurnIn = "Help OstrichSized",
			Alternatives = {
				{
					Text = "What's wrong?",
					End = true,
				},
			}
		},
		{
			Name = "OstrichSized_WiseWizard_START",
			RequiredQuests = {
				{
					Name = "Help OstrichSized",
					Status = "TurnedIn"
				},
				{
					Name = "Wise Wizard",
					Status = "NotUnlocked"
				}
			},
			Text = "Find my wizard friend Matt Dusek, he will explain things to you...",
			Alternatives = {
				{
					Text = "Sure, which way did he go?",
					Quest = "Wise Wizard",
					End = true,
					Response = {
						Text = "He was last seen behind my pyramid, searching..."
					}
				}
			}
		},
		{
			Name = "OstrichSized_MummysHome_CHECKUP",
			RequiredQuests = {
				{
					Name = "Mummy's Home",
					Status = "Inventory"
				}
			},
			TurnIn = "Mummy's Home",
			Text = "Oh no oh no, this is terrible...",
			Alternatives = {
				{
					Text = "What is it now OstrichSized?",
					End = true,
					Response = {
						Text = "Now I have a new problem...."
					}
				},
				{
					Text = "Oh what is it now?!",
					End = true,
					Response = {
						Text = "Now I have a new problem...."
					}
				}
			}
		},
		{
			Name = "OstrichSized_CreeperCrunchies_START",
			RequiredQuests = {
				{
					Name = "Mummy's Home",
					Status = "TurnedIn"
				},
				{
					Name = "Creeper Crunchies",
					Status = "NotUnlocked"
				}
			},
			Text = "An00bus has returned, but I'm completely out of Crawler Crunchies and he's so hungry!",
			Alternatives = {
				{
					Text = "How can I help?",
					Response = {
						Text = "Find some Creeper Crunchies and bring them to Creature Keeper.",
						Alternatives = {
							{
								Text = "I'm on my way! Don't worry An00bus!",
								End = true,
								Quest = "Creeper Crunchies",
								Response = {
									Text = "Thank you, and An00bus thanks you too"
								}
							},
							{
								Text = "I don't want to walk anymore!",
								End = true
							}
						}
					}
				},
				{
					Text = "Can't he eat all these monsters of something!?",
					End = true,
				}
			}
		},
		{
			Name = "OstrichSized_AllWrappedUp_START",
			RequiredQuests = {
				{
					Name = "Tomb Sweet Tomb",
					Status = {"Inventory","TurnedIn"}
				},
				{
					Name = "All Wrapped Up",
					Status = "NotUnlocked"
				}
			},
			TurnIn = "Tomb Sweet Tomb",
			Text = "I'm sure I can trust with you my BLOXikin, but before I bestow you with my power, you must do one final thing!",
			Alternatives = {
				{
					Text = "What should I do?",
					Response = {
						Text = "I think An00bus and your companion could be good friends, if only your companion fit in a little better...Maybe with a costume! The complete mummy costume!",
						Alternatives = {
							{
								Text = "Don't worry, I've got this under wraps!",
								Quest = "All Wrapped Up",
								End = true
							},
							{
								Text = "I don't want to dress my companion up like gross dusty mummy!",
								End = true
							}
						}
					}
				},
				{
					Text = "I'm done doing things for that creepy creeper!",
					End = true
				}
			}
		},
		{
			Name = "OstrichSized_AllWrappedUp_MID",
			RequiredQuests = {
				{
					Name = "All Wrapped Up",
					Status = "Inventory"
				}
			},
			Text = "Your companion still doesn't have that whole....mummy feel! How is it going?",
			Alternatives = {
				{
					Text = "I think I find pieces, but sometimes they're just rags...",
					End = true
				}
			}
		},
		{
			Name = "OstrichSized_AllWrappedUp_DONE",
			RequiredQuests = {
				{
					Name = "All Wrapped Up",
					Status = "AllItems"
				}
			},
			TurnIn = "All Wrapped Up",
			Text = "Your companion and An00bus look great together! Like true friends! Thank you!",
			Alternatives = {
				{
					Text = "Thanks OstrichSized! Bloxhilda is history thanks to your help!",
					End = true
				},
			}
		},
		{
			Name = "OstrichSized_FALLBACK",
			RequiredQuests = nil,
			Text = "The fate of Bloxburg lays in your hands!",
			Alternatives = {
				{
					Text = "I won't let the Admins down!",
					--TODO: Might be incorrect.
					End = true
				}
			}
		}
	},
	
	["Matt Dusek"] = {
		{
			Name = "Matt Dusek_WiseWizard_CHECKUP",
			RequiredQuests = {
				{
					Name = "Wise Wizard",
					Status = "Inventory"
				}
			},
			Text = "Oh thank goodness you're here!",
			TurnIn = "Wise Wizard",
			Alternatives = {
				{
					Text = "OstrichSized sent me to find you!",
					End = true
				}
			}
		},
		{
			Name = "Matt Dusek_ScareubScuffle_START",
			RequiredQuests = {
				{
					Name = "Wise Wizard",
					Status = "TurnedIn"
				},
				{
					Name = "Scare-ub Scuffle",
					Status = "NotUnlocked"
				}
			},
			Text = "Yes, OstrichSized is so upset these days. The web team's pet crawler An00bus has been frightened away by the scare-ubs, we have searched for him but he is not in his usual web-site.",
			Alternatives = {
				{
					Text = "How can I help?",
					Response = {
						Text = "Maybe if we wipe out enough of the scare-ubs, An00bus will return on his own...my magic can only do so much, will you assist me?",
						Alternatives = {
							{
								Text = "So how can I help?",
								Response = {
									Text = "Do away this 10 scare-ubs, then return to me and see what An00bus will do.",
									Alternatives = {
										{
											Text = "You got it!",
											Quest = "Scare-ub Scuffle",
											End = true
										},
										{
											Text = "No way! Let him stay lost!",
											End = true
										}
									}
								}
							},
							{
								Text = "What a scaredy spider!",
								End = true
							}
						}
					}
				},
				{
					Text = "I don't want to help, it's too hot out here!",
					End = true
				}
			}
		},
		{
			Name = "Matt Dusek_ScareubScuffle_DONE",
			RequiredQuests = {
				{
					Name = "Scare-ub Scuffle",
					Status = "AllItems"
				}
			},
			TurnIn = "Scare-ub Scuffle",
			Text = "Were you able to get them all?",
			Alternatives = {
				{
					Text = "You bet.",
					End = true
				}
			}
		},
		{
			Name = "Matt Dusek_SqueekyScarabs_START",
			RequiredQuests = {
				{
					Name = "Scare-ub Scuffle",
					Status = "TurnedIn"
				},
				{
					Name = "Squeeky Scarabs",
					Status = "NotUnlocked"
				}
			},
			Text = "The scare-ubs have been defeated but my magic tells me that An00bus has still not returned home. Maybe he wants his toys that the jackals stole...",
			Alternatives = {
				{
					Text = "Toys? Creepers have toys?",
					Response = {
						Text = "Yes, his beloved squeeky scarabs!",
						Alternatives = {
							{
								Text = "So what should I do?",
								Response = {
									Text = "Defeat 10 Sneaky Desert Jackals and bring me his lost 10 squeeky scarabs.",
									Alternatives = {
										{
											Text = "Sure thing, Ill get this under wraps!",
											Quest = "Squeeky Scarabs",
											End = true
										},
										{
											Text = "No way, I don't even like creepers...",
											End = true
										}
									}
								}
							},
							{
								Text = "Well he is, he should get over it!",
								End = true
							}
						}
					}
				},
				{
					Text = "Well if he does, he should get over it!",
					End = true
				}
			}
		},
		{
			Name = "Matt Dusek_SqueekyScarabs_DONE",
			RequiredQuests = {
				{
					Name = "Squeeky Scarabs",
					Status = "AllItems"
				}
			},
			TurnIn = "Squeeky Scarabs",
			Text = "Oh happy day! I have a feeling this will work nicely.",
			Alternatives = {
				{
					Text = "I hope so! I'm all wound up!",
					Response = {
						Text = "I believe I just spied An00bus running for the front of the pyramid! An00bus is home!",
						Alternatives = {
							{
								Text = "Oh good!",
								Response = {
									Text = "I'm sure OstrichSized will be so happy to see him.",
									Alternatives = {
										{
											Text = "Thank you MattDusek!",
											End = true
										},
										{
											Text = "Who cares, crawlers are gross.",
											End = true
										}
									}
								}
							},
							{
								Text = "Yeah, whatever...",
								End = true
							}
						}
					}
				},
				{
					Text = "Eww they're all covered in jackal spit!",
					End = true
				}
			}
		},
		{
			Name = "Matt Dusek_MummysHome_START",
			RequiredQuests = {
				{
					Name = "Squeeky Scarabs",
					Status = "TurnedIn"
				},
				{
					Name = "Mummy's Home",
					Status = "NotUnlocked"
				}
			},
			Text = "Check in with OstrichSized and see if An00bus has indeed returned",
			Alternatives = {
				{
					Text = "Right away!",
					Quest = "Mummy's Home",
					End = true
				},
				{
					Text = "Do it yourself.",
					End = true
				}
			}
		},
		{
			Name = "Matt Dusek_GrabABite_START",
			RequiredQuests = {
				{
					Name = "Tomb Sweet Tomb",
					Status = "TurnedIn"
				},
				{
					Name = "Grab a Bite",
					Status = "NotUnlocked"
				}
			},
			Text = "Greetings hero! All is well here, but you should continue on to StickMasterLuke, to see if Bloxhilda's powers have effected him.",
			Alternatives = {
				{
					Text = "On my way!",
					Quest = "Grab a Bite",
					End = true,
				},
			}
		},
	},
	
	["Creature Keeper"] = {
		{
			Name = "Creature Keeper_CreeperCrunchies_DONE",
			RequiredQuests = {
				{
					Name = "Creeper Crunchies",
					Status = "AllItems"
				}
			},
			TurnIn = "Creeper Crunchies",
			Text = "Oh thank goodness you're here!",
			Alternatives = {
				{
					Text = "OstrichSized sent me to find you!",
					End = true
				}
			}
		},
		{
			Name = "Creature Keeper_JackalAndHide_START",
			RequiredQuests = {
				{
					Name = "Creeper Crunchies",
					Status = "TurnedIn"
				},
				{
					Name = "Jackal and Hide",
					Status = "NotUnlocked"
				}
			},
			Text = "This is a good start, but An00bus will need more and the rest of mine were stolen!",
			Alternatives = {
				{
					Text = "Stolen?!",
					Response = {
						Text = "The desert jackals have stolen all the Creeper Crunchies, but perhaps you could loot it from them...",
						Alternatives = {
							{
								Text = "So how can I help?",
								Response = {
									Text = "It was a pack of 20 desert jackals, it should take that many to have enough to feet a hungry creeper.",
									Alternatives = {
										{
											Text = "You got it!",
											End = true,
											Quest = "Jackal and Hide"
										},
										{
											Text = "No way! Let him go hungry!",
											End = true
										}
									}
								}
							},
							{
								Text = "What a scaredy spider!",
								End = true
							}
						}
					}
				},
				{
					Text = "I say let them keep it, I don't like creepers!",
					End = true
				}
			}
		},
		{
			Name = "Creature Keeper_JackalAndHide_DONE",
			--TODO: This dialog is fabricated.
			RequiredQuests = {
				{
					Name = "Jackal and Hide",
					Status = "AllItems"
				},
				{
					Name = "Tomb Sweet Tomb",
					Status = "NotUnlocked"
				}
			},
			TurnIn = "Jackal and Hide",
			Text = "I sense that you have the Creeper Crunchies.",
			Alternatives = {
				{
					Text = "Sure do! Am I done yet??",
					Response = {
						Text = "Yes, almost. Just head over to Ostrich! He has one more quest for you.",
						Quest = "Tomb Sweet Tomb",
						End = true
					}
				}
			}
		},
		{
			Name = "Creature Keeper_JackalAndHide_DONE2",
			--TODO: This dialog is fabricated.
			RequiredQuests = {
				{
					Name = "Jackal and Hide",
					Status = "TurnedIn"
				},
				{
					Name = "Tomb Sweet Tomb",
					Status = "NotUnlocked"
				}
			},
			Text = "I sense that you have the Creeper Crunchies.",
			Alternatives = {
				{
					Text = "Sure do! Am I done yet??",
					Response = {
						Text = "Yes, almost. Just head over to Ostrich! He has one more quest for you.",
						Quest = "Tomb Sweet Tomb",
						End = true
					}
				}
			}
		},
		{
			Name = "Creature Keeper_FALLBACK",
			RequiredQuests = nil,
			Text = "Sorry, I specialize only in feed for more monsterious companions than yours.",
			Alternatives = {
				{
					Text = "We just ate anyway!",
					End = true
				}
			}
		},
	},
	
	["SolarCrane"] = {
		{
			Name = "SolarCrane_FriendlySolarCrane_CHECKUP",
			RequiredQuests = {
				{
					Name = "Friendly Solar Crane",
					Status = "Inventory"
				}
			},
			Text = "AH! Oh, you arnt a ghost...",
			TurnIn = "Friendly Solar Crane",
			Alternatives = {
				{
					Text = "Ghosts? What are you talking about?",
					End = true,
				}	
			}
		},
		{
			Name = "SolarCrane_BumpInTheNight_START",
			RequiredQuests = {
				{
					Name = "Bump In The Night",
					Status = "NotUnlocked"
				}
			},
			Text = "I think my house might be haunted...or something...Maybe? I don't know...",
			Alternatives = {
				{
					Text = "Ghosts?! Then what do we need to do?",
					Response = {
						Text = "Well, it would be polite to ask them to leave before we do anything harsh, right? We should hold a seance...",
						Alternatives = {
							{
								Text = "So how can I help?",
								End = true,
								Quest = "Bump In The Night",
								Response = {
									Text = "Well to start a seance, we'll need 10 ghost candles.",
								}
							},
							{
								Text = "I'm not going to help, ghosts are just pretend!",
								End = true
							}
						}
					},
				},
				{
					Text = "Maybe your house just has indigestion...",
					End = true
				}	
			}
		},
		{
			Name = "SolarCrane_BumpInTheNight_DONE",
			RequiredQuests = {
				{
					Name = "Bump In The Night",
					Status = "AllItems"
				}
			},
			Text = "Oh you found them! That's great!...I think...",
			TurnIn = "Bump In The Night",
			Alternatives = {
				{
					Text = "No problem, I just hope it works.",
					End = true,
					Response = {
						Text = "Oh this is great, thank you."
					}
				}	
			}
		},
		{
			Name = "SolarCrane_PawinormalActivity_START",
			RequiredQuests = {
				{
					Name = "Bump In The Night",
					Status = "TurnedIn"
				},
				{
					Name = "Paw-inormal Activity",
					Status = "NotUnlocked"
				}
			},
			Text = "Oh so..uh...looks like the ghosts have possessed the wolves and stuff around here....",
			Alternatives = {
				{
					Text = "Ghost wolves!? No way!",
					Response = {
						Text = "There's a big pack of them around here, take out 20 of them so i can get the seance started...",
						Alternatives = {
							{
								Text = "207 - Ghost buster to the rescue!",
								Quest = "Paw-inormal Activity",
								End = true
							},
							{
								Text = "What's so simple about ghost wolves!?",
								End = true
							},
						}
					}
				},
				{
					Text = "More fighting? Smell you later...",
					End = true
				}
			}
		},
		{
			Name = "SolarCrane_PawinormalActivity_DONE",
			RequiredQuests = {
				{
					Name = "Paw-inormal Activity", 
					Status = "AllItems"
				}
			},
			Text = "You are quite the ghost buster!",
			TurnIn = "Paw-inormal Activity",
			Alternatives = {
				{
					Text = "Who you gonna call? ME!",
					End = true,
				}	
			}
		},
		{
			Name = "SolarCrane_SpookyScholar_START",
			RequiredQuests = {
				{
					Name = "Paw-inormal Activity",
					Status = "TurnedIn"
				},
				{
					Name = "Spooky Scholar",
					Status = "NotUnlocked"
				}
			},
			Text = "Now my seance is ready to go, but...I still can't get though, I should consult an expert...",
			Alternatives = {
				{
					Text = "A ghost expert? Like who?",
					Response = {
						Text = "Raeglyn knows a lot about ghosts, she knows a lot about a lot...",
						Alternatives = {
							{
								Text = "I'm on it!",
								Quest = "Spooky Scholar",
								End = true
							}
						}
					}
				},
				{
					Text = "An expert on make believe? Because ghosts are not real...",
					End = true,
				}
			}
		},
		{
			Name = "SolarCrane_SpookyScholar_MID",
			RequiredQuests = {
				{
					Name = "Spooky Scholar",
					Status = "Inventory"
				}
			},
			Text = "Did you talk to Raeglyn yet?",
			Alternatives = {
				{
					Text = "Not yet.",
					End = true,
				}	
			}
		},
		{
			Name = "SolarCrane_CadaverousPallor_START",
			RequiredQuests = {
				{
					Name = "Ghost Go Home",
					Status = {"Inventory","TurnedIn"}
				},
				{
					Name = "Cadaverous Pallor",
					Status = "NotUnlocked"
				}
			},
			Text = "Oh welcome back! What's this?....oh.",
			TurnIn = "Ghost Go Home",
			Alternatives = {
				{
					Text = "What? What does the message say?",
					Response = {
						Text = "The message... it says... come closer... closer... closer my friend... BOO!",
						Alternatives = {
							{
								Text = "Oh my gawd!! Erm... I mean what does it really say?",
								End = true,
								Quest = "Cadaverous Pallor",
								Response = {
									Text = "It says the ghosts are lonely and miss their pets. Maybe your companion could cheer them up."
								}
							},
						}
					}
				}	
			}
		},
		{
			Name = "SolarCrane_CadaverousPallor_DONE",
			RequiredQuests = {
				{
					Name = "Cadaverous Pallor",
					Status = "AllItems"
				}
			},
			Text = "Look at that! Oooh that's too spooky for me!",
			TurnIn = "Cadaverous Pallor",
			Alternatives = {
				{
					Text = "Thanks SolarCrane!",
					End = true,
					Response = {
						Text = "Here we go! As promised, my BLOXikin."
					}
				}	
			}
		},
		{
			Name = "SolarCrane_SkeleTroll", 			
			RequiredQuests = {
				{
					Name = "Cadaverous Pallor",
					Status = "TurnedIn"
				},
				{
					Name = "Skele-Troll",
					Status = "NotUnlocked"
				}
			},
			Text = "Oh you should go check on Sorcus. Even a troll isn't immune to a witch.",
			Alternatives = {
				{
					Text = "Oh man, Sorcus!?",
					End = true,
					Quest = "Skele-Troll"
				}	
			}
		},
	},
	
	["Raeglyn"] = {
		{
			Name = "Raeglyn_SpookyScholar_CHECKUP",
			RequiredQuests = {
				{
					Name = "Spooky Scholar",
					Status = "Inventory"
				}
			},
			Text = "Oh hello? Can I help you?",
			TurnIn = "Spooky Scholar",
			Alternatives = {
				{
					Text = "SolarCrane sent me to find you",
					End = true,
					Response = {
						Text = "Oh what does he need now?"
					}
				}	
			}
		},
		{
			Name = "Raeglyn_SpiritBox_START",
			RequiredQuests = {
				{
					Name = "Spooky Scholar",
					Status = "TurnedIn"
				},
				{
					Name = "Spirit Box",
					Status = "NotUnlocked"
				}
			},
			Text = "A seance huh? Well from how you described it, hes going about it all wrong.",
			Alternatives = {
				{
					Text = "Then what's the right way?",
					Response = {
						Text = "You can't talk to ghosts with silly magic, you need science! I was making a machine to speak with spirits, but those darn ghost spiders and wolves made off with the parts.",
						Alternatives = {
							{
								Text = "How many parts were there?",
								Quest = "Spirit Box",
								End = true,
								Response = {
									Text = "13 parts, if you kill enough ghost creatures, maybe you can find them all."
								}
							},
							{
								Text = "No way, what a waste of my time!",
								End = true
							}
						}
					}
				},
				{
					Text = "A ghost talking machine? That's nonsense...",
					End = true
				}
			}
		},
		{
			Name = "Raeglyn_SpiritBox_DONE",
			RequiredQuests = {
				{
					Name = "Spirit Box",
					Status = "AllItems"
				}
			},
			Text = "Oh you found them?",
			TurnIn = "Spirit Box",
			Alternatives = {
				{
					Text = "This should be all the pieces",
					End = true,
					Response = {
						Text = "Thank you, now my spirit communicator can be completed again!"
					}
				}	
			}
		},
		{
			Name = "Raeglyn_GhostWarrior_START",
			RequiredQuests = {
				{
					Name = "Spirit Box", 
					Status = "TurnedIn"
				},
				{
					Name = "Ghost Warrior", 
					Status = "NotUnlocked"
				},
			},
			Text = "Now that the spirit box is repaired, we can communicate with the spirits, and see why they're haunting SolarCrane",
			Alternatives = {
				{
					Text = "Great! What do the spirits say?",
					Response = {
						Text = "Hrrm, they seem to demand you prove yourself...with a battle against 20 of their mighty ghost warriors.",
						Alternatives = {
							{
								Text = "Then I shall prepare for battle!",
								End = true,
								Quest = "Ghost Warrior"
							},
							{
								Text = "I can't fight something that doesn't exist!",
								End = true
							}
						}
					}
				},
				{
					Text = "Uh huh, sure. Like ghosts aren't make-believe.",
					End = true
				}
			}
		},
		{
			Name = "Raeglyn_GhostWarrior_DONE",
			RequiredQuests = {
				{
					Name = "Ghost Warrior",
					Status = "AllItems"
				},
			},
			Text = "You've proven yourself worthy against the ghosts.",
			TurnIn = "Ghost Warrior",
			Alternatives = {
				{
					Text = "It was nothing.",
					End = true,
				}	
			}
		},
		{
			Name = "Raeglyn_GhostGoGome_START",
			RequiredQuests = {
				{
					Name = "Ghost Warrior",
					Status = "TurnedIn"
				},
				{
					Name = "Ghost Go Home",
					Status = "NotUnlocked"
				}
			},
			Text = "The ghosts are now willing to communicate. Deliver this message containing their wishes to SolarCrane.",
			Alternatives = {
				{
					Text = "For SolarCrane!",
					Response = {
						Text = "Yes... yes, I concur.",
						Alternatives = {
							{
								Text = "You got it.",
								End = true,
								Quest = "Ghost Go Home",
								Response = {
									Text = "Thanks!"
								}
							}
						}
					}
				},
				{
					Text = "NO! TOO MANY STAIRS!",
					End = true
				}
			}
		},
	},
	
	["Darthskrill"] = {
		{
			Name = "Darthskrill_DanceRayGun_CHECKUP",
			RequiredQuests = {
				{
					Name = "Dance Ray Gun", 
					Status = "Inventory"
				}
			},
			TurnIn = "Dance Ray Gun",
			Text = "Hello, noble ROBLOXian, it is I, Darthskrill. It looks like you have come to retrieve BrightEyes Dance Ray Gun.",
			Alternatives = {
				{
					Text = "Yeah, how'd you know that? Well anyway thanks!",
					End = true,
				}
			}
		},
		{
			Name = "Darthskrill_AttackOfTheSwampWolves_START",
			RequiredQuests = {
				{
					Name = "Attack Of The SwampWolves",
					Status = "NotUnlocked"
				},
				{
					Name = "Dance Ray Gun",
					Status = "TurnedIn"
				}
			},
			Text = "Hello fellow Builder! I'd like to help you but ever since Bloxhilda has returned, I'm so busy fighting off these swamp wolves!",
			Alternatives = {
				{
					Text = "What's wrong with the wolves?",
					Response = {
						Text = "They used to be friendly, but Bloxhilda's return has disturbed their nature...",
						Alternatives = {
							{
								Text = "How can I help?",
								Response = {
									Text = "I think if you take out 15, that'll help me out a lot!",
									Alternatives = {
										{
											Text = "On it!",
											Quest = "Attack Of The SwampWolves",
											End = true
										},
										{
											Text = "Hey maybe the swamp wolves aren't so bad...",
											End = true
										}
									}
								}
							},
							{
								Text = "No way! Swamp Wolves are alright with me!",
								End = true
							}
						}
					}
				},
				{
					Text = "You look like you could use some help!",
					End = true
				},
				{
					Text = "Your house is disgusting. You should be ashamed.",
					End = true
				}
			}
		},
		{
			Name = "Darthskrill_AttackOfTheSwampWolves_DONE",
			RequiredQuests = {
				{
					Name = "Attack Of The SwampWolves",
					Status = "AllItems"
				}
			},
			Text = "Thanks so much! You've really helped me out.",
			TurnIn = "Attack Of The SwampWolves",
			Alternatives = {
				{
					Text = "They weren't so tough! Any time Darthskrill!",
					End = true,
				}	
			}
		},
		{
			Name = "Darthskrill_MissingCodewriter_START",
			RequiredQuests = {
				{
					Name = "Attack Of The SwampWolves",
					Status = "TurnedIn"
				},
				{
					Name = "Missing CodeWriter",
					Status = "NotUnlocked"
				}
			},
			Text = "Can you go look for CodeWriter? He went into the swamp to fight swamp wolves too, and hasn't come back...",
			Alternatives = {
				{
					Text = "Sure, which way did he go?",
					Response = {
						Text = "He headed toward the biggest tree",
						Alternatives = {
							{
								Text = "Ill go look for him.",
								End = true,
								Quest = "Missing CodeWriter"
							},
							{
								Text = "I'm sure he's fine! Nothing to worry about.",
								End = true
							}
						}
					}
				},
				{
					Text = "CodeWriter? But he never PM'd me back...",
					End = true
				}
			}
		},
		{
			Name = "Darthskrill_MissionAccomplished_CHECKUP",
			RequiredQuests = {
				{
					Name = "Mission Accomplished",
					Status = "Inventory"
				}
			},
			Text = "Oh, you found Code Writer?",
			TurnIn = "Mission Accomplished",
			Alternatives = {
				{
					Text = "He's fine, here's a necklace to keep the wolves away.",
					End = true,
					Response = {
						Text = "Oh thank you.. it smells like spider spit..."
					}
				}
			}
		},
		{
			Name = "Darthskrill_ItsNotEasyBeinGreen_START", 			
			RequiredQuests = {
				{
					Name = "It's Not Easy Bein' Green", 
					Status = "NotUnlocked"
				},
				{
					Name = "Mission Accomplished",
					Status = "TurnedIn"
				}
			},
			Text = "So Builderman has sent you to gather BLOXikins, huh? Such powerful items are dangerous, you must prove to me that you are one with the swamp in order for me to trust you with my BLOXikin.",
			Alternatives = {
				{
					Text = "One with the swamp? Like...cover myself in mud?",
					Response = {
						Text = "That does sound like too much work...but your companion!",
						Alternatives = {
							{
								Text = "What about my companion?",
								Response = {
									Text = "Prove you are one with the swamp by completing your companions Swamp Creature costume.",
									Alternatives = {
										{
											Text = "Sure thing, I bet they'll look great in green!",
											Quest = "It's Not Easy Bein' Green",
											Response = {
												Text = "By the way, CodeWriter wanted to see you before you left."
											},
											End = true
										},
										{
											Text = "No way, I like how they look now...",
											End = true
										}
									}
								}
							},
							{
								Text = "I'm not putting mud on my companion either!",
								End = true
							}
						}
					}
				},
				{
					Text = "This swamp is gross, I don't need your BLOXikin anyway!",
					End = true
				}	
			}
		},
		{
			Name = "Darthskrill_ItsNotEasyBeinGreen_MID",
			RequiredQuests = {
				{
					Name = "It's Not Easy Bein' Green", 
					Status = "Inventory"
				}
			},
			Text = "Your companion is still not in harmony with the swamp!",
			Alternatives = {
				{
					Text = "Swamp? Like...moss and stuff?",
					End = true,
				}
			}
		},
		{
			Name = "Darthskrill_ItsNotEasyBeinGreen_DONE",
			RequiredQuests = {
				{
					Name = "It's Not Easy Bein' Green",
					Status = "AllItems"
				}
			},
			Text = "Much better! The swamp has accepted your companion whole-heartedly!",
			TurnIn = "It's Not Easy Bein' Green",
			Alternatives = {
				{
					Text = "Green is really my companion's color!",
					Response = {
						Text = "You've proven yourself a worthy friend of the swamp.",
						Alternatives = {
							{
								Text = "Of course! Thank you",
								Response = {
									Text = "Here, take my BLOXikin. Use its power wisely to banish Bloxhilda.",
									Alternatives = {
										{
											Text = "I'll do my best Darthskrill",
											End = true
										},
										{
											Text = "Maybe Ill just use this to join her!",
											End = true
										}
									}
								}
							},
							{
								Text = "Yeah, whatever...",
								End = true
							}
						}
					}
				}	
			}
		},
		{
			Name = "Darthskrill_ALL_DONE",
			RequiredQuests = {
				{
					Name = "It's Not Easy Bein' Green",
					Status = "TurnedIn"
				}
			},
			Text = "The fate of Bloxburg rests in your hands!",
			Alternatives = {
				{
					Text = "I won't let the Admins down!",
					End = true
				}	
			}
		},
	},
	
	["CodeWriter"] = {
		{
			Name = "CodeWriter_MissingCodeWriter_CHECKUP",
			RequiredQuests = {
				{
					Name = "Missing CodeWriter",
					Status = "Inventory"
				}
			},
			TurnIn = "Missing CodeWriter",
			Text = "Oh thank goodness you're here!",
			Alternatives = {
				{
					Text = "Darthskrill sent me to find you!",
					End = true,
				}
			}
		},
		{
			Name = "CodeWriter_SpiderSmash_START",
			RequiredQuests = {
				{
					Name = "Missing CodeWriter",
					Status = "TurnedIn"
				},
				{
					Name = "Spider Smash",
					Status = "NotUnlocked"
				}
			},
			Text = "I've discovered the swamp wolves wont go near swamp spiders. Maybe there's some way we can use them to make the wolves would leave us alone...",
			Alternatives = {
				{
					Text = "Maybe a fang necklace?",
					Response = {
						Text = "That's it, fangs! Maybe if we had some spider fangs the wolves would keep away.",
						Alternatives = {
							{
								Text = "So how can I help?",
								Response = {
									Text = "If you get me 12 pairs of Hairy Swamp Spiders fangs, we can make some necklaces to keep swamp wolves at bay.",
									Alternatives = {
										{
											Text = "You got it!",
											Quest = "Spider Smash",
											End = true
										},
										{
											Text = "I'm not putting my hands in a spider's mouth! That's gross!",
											End = true
										}
									}
								}
							},
							{
								Text = "Wolves don't care about fashion accessories!",
								End = true
							}
						}
					}
				},
				{
					Text = "I don't blame the swamp wolves, I don't want to go near spiders either!"
				}
			}
		},
		{
			Name = "CodeWriter_SpiderSmash_DONE",
			RequiredQuests = {
				{
					Name = "Spider Smash", 
					Status = "AllItems"
				}
			},
			Text = "Did you find them?",
			TurnIn = "Spider Smash",
			Alternatives = {
				{
					Text = "Yeah, wasn't that tough.",
					End = true,
				}	
			}
		},
		{
			Name = "CodeWriter_MissionAccomplished_START",
			RequiredQuests = {
				{
					Name = "Spider Smash",
					Status = "TurnedIn"
				},
				{
					Name = "Mission Accomplished",
					Status = "NotUnlocked"
				}
			},
			Text = "I'm fine now that I have my fang necklace. Hurry back to Darthskrill and let him know I'm fine.",
			Alternatives = {
				{
					Text = "Right away!",
					Quest = "Mission Accomplished",
					End = true
				},
				{
					Text = "Do it yourself.",
					End = true
				}
			}
		},
		{
			Name = "CodeWriter_SpreadTheGoodMews_START",
			RequiredQuests = {
				{
					Name = "Mission Accomplished", 
					Status = "TurnedIn"
				},
				{
					Name = "Spread The Good 'Mews'", 
					Status = "NotUnlocked"					
				}
			},
			Text = "Now my swamp is safe, but I'm worried for Tarabyte...",
			Alternatives = {
				{
					Text = "What do you want me to do?",
					Response = {
						Text = "Head to her home and make sure Bloxhilda's powers haven't reached her!",
						Alternatives = {
							{
								Text = "I'll head right over!",
								Quest = "Spread The Good 'Mews'",
								End = true
							},
							{
								Text = "Tarabyte?! No way, She never makes my retextures...",
								End = true
							}
						}
					}
				},
				{
					"That sounds too far away...",
					End = true
				}
			}
		},
	},
	
	
	["OnlyTwentyCharacters"] = {
		{
			Name = "OnlyTwentyCharacters_BarelyHuman_CHECKUP",
			RequiredQuests = {
				{
					Name = "Barely Human", 
					Status = "Inventory"					
				}
			},
			TurnIn = "Barely Human",
			Text = "[ We have no idea what OnlyTwentyCharacters is supposed to say here. ]",
			Alternatives = {
				{
					Text = "...its in the middle of the city.",
					End = true
				},
			}
		},
		{
			Name = "OnlyTwentyCharacters_StartingAFire_START",
			RequiredQuests = {
				{
					Name = "Starting a Fire", 
					Status = "NotUnlocked"					
				},
				{
					Name = "Barely Human",
					Status = "TurnedIn"
				}
			},
			Text = "I tried to move as far away as I could once I found out.",
			Alternatives = {
				{
					Text = "Looks like you didn't make it that far.",
					Response = {
						Text = "It seemed farther away at the time. Can you run into town for me? I shouldn't be around too many people.",
						Alternatives = {
							{
								Text = "What do you need?",
								Response = {
									Text = "I could use some matches. There is no electricity here. Get a bunch!",
									Alternatives = {
										{
											Text = "Okay.",
											End = true,
											Quest = "Starting a Fire"
										},
										{
											Text = "Meh.",
											End = true
										}
									}
								}
							},
							{
								Text = "Always errands with you people!",
								End = true
							}
						}
					}
				},
				{
					Text = "...",
					End = true
				}
			}
		},
		{
			Name = "OnlyTwentyCharacters_StartingAFire_DONE",
			RequiredQuests = {
				{
					Name = "Starting a Fire", 
					Status = "AllItems"					
				}
			},
			TurnIn = "Starting a Fire",
			Text = "Ah..perfect. Twenty boxes of matches.",
			Alternatives = {
				{
					Text = "Yeah, that's a lot.",
					Response = {
						Text = "No. It's Only Twenty. And here is BLOXikin #20 as a reward.",
						Alternatives = {
							{
								Text = "What is with you and twenty?",
								Response = {
									Text = "The better question is...why is this thing #20 instead of my BLOXikin?!",
									Alternatives = {
										{
											Text = "What number is yours?",
											End = true,
											Response = {
												Text = "It's not twenty! That's all that matters!"
											},
										},
										{
											Text = "Because it's cooler?",
											End = true
										}
									}
								}
							},
							{
								Text = "Thanks!",
								End = true
							}
						}
					}
				},
				{
					Text = "Too many! I hope you burn down your Log Cabin.",
					End = true
				}
			}
		},
		{
			Name = "OnlyTwentyCharacters_ImNotFood_START",
			RequiredQuests = {
				{
					Name = "Starting a Fire",
					Status = "TurnedIn"
				},
				{
					Name = "I'm not food!",
					Status = "NotUnlocked"
				}
			},
			Text = "Ugh! You've ruined my day! <snarls>",
			Alternatives = {
				{
					Text = "Whoa! I didn't do anything! You gave it to me!",
					Response = {
						Text = "You should leave. Dbapostle is in the back. Talk to him while I try to not eat you.",
						Alternatives = {
							{
								Text = "Eat!?!? <backs away>",
								Response = {
									Text = "Did I forget to mention, I'm a werewolf?",
									Alternatives = {
										{
											Text = "<runs>",
											Quest = "I'm not food!",
											End = true,
										},
										{
											Text = "<faints>",
											End = true
										}
									}
								}
							},
							{
								Text = "Interesting diet. Do you prefer arms or legs?",
								End = true,
								Response = {
									Text = "GRRR!"
								}
							},
							{
								Text = "Maybe you should be on Bloxhilda's side, like me?",
								End = true
							}
						}
					}
				},
				{
					Text = "Great! I plan to undermine all your plans!",
					End = true
				}
			}
		},
		{
			Name = "OnlyTwentyCharacters_IsItSafe_CHECKUP",
			RequiredQuests = {
				{
					Name = "Is it safe?",
					Status = "Inventory"
				}
			},
			TurnIn = "Is it safe?",
			Text = "It seems Dbapostle kept you busy long enough. Let's get you that BLOXikin.",
			Alternatives = {
				{
					Text = "<stands back a bit> Great...",
					End = true
				},
			}
		},
		{
			Name = "OnlyTwentyCharacters_Wolfy_START",	
			RequiredQuests = {
				{
					Name = "Is it safe?", 
					Status = "TurnedIn"					
				},
				{
					Name = "Wolfy", 
					Status = "NotUnlocked"					
				}
			},
			Text = "Alright...so you already know I'm a werewolf. What do you think I need?",
			Alternatives = {
				{
					Text = "Werewolf companion set?",
					Response = {
						Text = "Yup, hop to it!",
						Alternatives = {
							{
								Text = "Sighs...okay.",
								End = true,
								Quest = "Wolfy"
							},
							{
								Text = "I'm done dressing my companion up!",
								End = true
							}
						}
					}
				},
				{
					Text = "Nothing!",
					End = true
				}
			}
		},
		{
			Name = "OnlyTwentyCharacters_Wolfy_DONE",		
			RequiredQuests = {
				{
					Name = "Wolfy", 
					Status = "AllItems"					
				}
			},
			TurnIn = "Wolfy",
			Text = "Alright, looks good. Here's the best BLOXikin out there.",
			Alternatives = {
				{
					Text = "But its not #20.",
					End = true,
					Response = {
						Text = "...",
					}
				},
				{
					Text = "I think I like #20 the raven better.",
					End = true
				}
			}
		},
		{
			Name = "OnlyTwentyCharacters_FALLBACK",
			RequiredQuests = nil,
			Text = "Why is my BLOXikin not #20!! I blame Tarabyte...",
			Alternatives = {
				{
					Text = "Is it that important?",
					End = true,
					Response = {
						Text = "<grumble, grumble>"
					}
				},
				{
					Text = "Why do you blame her?",
					End = true,
					Response = {
						Text = "grumble, grumble>"
					}
				}
			}
		}
	},
	
	["Dbapostle"] = {
		{
			Name = "Dbapostle_ImNotFood_CHECKUP",
			RequiredQuests = {
				{
					Name = "I'm not food!",
					Status = "Inventory"
				}
			},
			TurnIn = "I'm not food!",
			Text = "Hello. Is OnlyTwentyCharacters angry over not having #20 again?",
			Alternatives = {
				{
					Text = "Yeah...",
					End = true,
					Response = {
						Text = "I'm not surprised"
					}
				}
			}
		},
		{
			Name = "Dbapostle_DogTreats_START",	
			RequiredQuests = {
				{
					Name = "I'm not food!",
					Status = "TurnedIn"
				},
				{
					Name = "Dog Treats",
					Status = "NotUnlocked"
				}
			},
			Text = "Mind helping me stock up on some supplies?",
			Alternatives = {
				{
					Text = "Supplies?",
					Response = {
						Text = "Yeah I keep some Dog Treats handy incase Only20 tries to eat me.",
						Alternatives = {
							{
								Text = "That works?",
								End = true,
								Quest = "Dog Treats",
								Response = {
									Text = "Well yeah...just like steaks to a zombie."
								}
							},
							{
								Text = "Too unrealistic!",
								End = true
							}
						}
					}
				},
				{
					Text = "I'm done running errands!",
					End = true
				}
			}
		},
		{
			Name = "Dbapostle_DogTreats_DONE",
			RequiredQuests = {
				{
					Name = "Dog Treats",
					Status = "AllItems"
				}
			},
			TurnIn = "Dog Treats",
			Text = "Heh, thanks. I'm going to be safe for quite some time with those.",
			Alternatives = {
				{
					Text = "No problem!",
					End = true
				},
				{
					Text = "Whatever.",
					End = true
				}
			}
		},
		{
			Name = "Dbapostle_CleanupCrew_START",
			RequiredQuests = {
				{
					Name = "Dog Treats",
					Status = "TurnedIn"
				},
				{
					Name = "Clean-up Crew",
					Status = "NotUnlocked"
				}
			},
			Text = "Mind cleaning up some of the Bloxhilda minions we get out here?",
			Alternatives = {
				{
					Text = "Do I get something?",
					Response = {
						Text = "Maybe...",
						Alternatives = {
							{
								Text = "I'll take the chance.",
								End = true,
								Quest = "Clean-up Crew"
							},
							{
								Text = "Then no.",
								End = true
							}
						}
					}
				},
				{
					Text = "Sure!",
					Quest = "Clean-up Crew",
					End = true,
					Response = {
						Text = "Come back when you have defeated 13 ghost spiders!"
						--NOTE: This is a response GUI made by konlon15 and was NOT in the original.
						--TODO: Is this actually needed?
					}
				},
				{
					Text = "I mind.",
					End = true
				}
			}
		},
		{
			Name = "Dbapostle_CleanupCrew_DONE",
			RequiredQuests = {
				{
					Name = "Clean-up Crew",
					Status = "AllItems"
				}
			},
			TurnIn = "Clean-up Crew",
			Text = "Looking safe again! At least for a few minutes.",
			Alternatives = {
				{
					Text = "Haha! Yeah those minions don't know how to give up!",
					End = true,
				},
			}
		},
		{
			Name = "Dbapostle_IsItSafe_FriendlySolarCrane_START",
			RequiredQuests = {
				{
					Name = "Clean-up Crew",
					Status = "TurnedIn"
				},
				{
					Name = "Is it safe?",
					Status = "NotUnlocked"
				},
				{
					Name = "Friendly Solar Crane",
					Status = "NotUnlocked"
				}
			},
			Text = "He should be done raging now.",
			Alternatives = {
				{
					Text = "Will I be safe to get the BLOXikin?",
					Quest = "Is it safe?",
					Response = {
						Text = "Yeah...it should be okay. Also, head over to the Haunted House.",
						Alternatives = {
							{
								Text = "Can do!",
								Quest = "Friendly Solar Crane",
								End = true
							}
						}
					}
				},
				{
					Text = "I'm not talking to that crazy!",
					End = true
				}
			}
		},
		{
			Name = "Dbapostle_FALLBACK", 			
			RequiredQuests = nil,
			Text = "Hanging out with a werewolf can be tiring....",
			Alternatives = {
				{
					Text = "I bet, especially when he rages over a number.",
					End = true
				}
			}
        }
    }
}