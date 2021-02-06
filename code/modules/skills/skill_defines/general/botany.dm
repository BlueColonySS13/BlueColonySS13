
//botany
/datum/category_item/skill/general/botany
	id = SKILL_BOTANY
	name = "Botany"
	flavor_desc = "Describes how good your character is at caring for animals, growing and maintaining plants."
	govern_desc = "Governs your chances at collecting seeds and plant yield."
	typical_desc = "A low level is typical for people who may have had access to a plant or a garden at some point of their lives. \
	A high level is typical of professionals who has scientific knowledge of plants and."
	levels = list(
		/datum/skill_level/botany/zero,
		/datum/skill_level/botany/one,
		/datum/skill_level/botany/two,
		/datum/skill_level/botany/three
		)

/datum/skill_level/botany/zero
	name = "Untrained"
	flavor_desc = "You probably have seen how people plant seeds into the ground and have a basic idea of how it works, but everything else\
	is quite alien to you."
	mechanics_desc = "Can wear emergency soft-suits.<br>\
	Can operate internals, and cooling units.<br>\
	Will always fall down when entering an area with gravity from an area lacking it, without magboots.<br>\
	Slipping in space is possible if not secured to a surface."

/datum/skill_level/botany/one
	name = "Botany Trained"
	flavor_desc = "You can comfortably use a space suit, and may do so regularly in the course of your work. \
	You’ve also been trained in the usage of various pieces of equipment for EVA."
	mechanics_desc = "Allows you to understand data on the plant analyser.<br>\
	Can toggle magnetic boots.<br>\
	Can toggle jetpacks, and fly in space with one."
	cost = 10

/datum/skill_level/botany/two
	name = "Botany Specialist"
	flavor_desc = "You can use all kinds of space suits, including specialized powered suits., and you’ve become accustomed to using a jetpack to move around."
	mechanics_desc = "Can wear RIG suits.<br>\
	Can toggle stabilization setting on jetpacks to remain in place in space."
	cost = 20

/datum/skill_level/botany/three
	name = "Botany Expert"
	flavor_desc = "You are just as much at home in a vacuum as in atmosphere. Your training and experience helps keep you from being disoriented in space."
	mechanics_desc = "Voidsuit and RIG encumbrance is reduced somewhat.<br>\
	Will no longer slip in space due to being unsecured.<br>\
	Will land gracefully when suddenly entering gravity, instead of falling to the ground."
	enhancing = TRUE
	cost = 40

