/datum/category_item/crafting/sewing_machine/leather
	prefix = "leather"
	force_matter = list("leather" = 2400)

/datum/category_item/crafting/sewing_machine/leather/sheets
	name = "sheets"
	path = /obj/item/stack/material/leather
	is_stack = 1

// suits

/datum/category_item/crafting/sewing_machine/leather/coat
	name = "coat"
	path = /obj/item/clothing/suit/storage/toggle/coat
	override_color = COLOR_BROWN

/datum/category_item/crafting/sewing_machine/leather/longcoat
	name = "long coat"
	path = /obj/item/clothing/suit/leathercoat

/datum/category_item/crafting/sewing_machine/leather/longcoat
	name = "long coat"
	path = /obj/item/clothing/suit/leathercoat

/datum/category_item/crafting/sewing_machine/leather/jacket
	name = "black jacket"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket

/datum/category_item/crafting/sewing_machine/leather/sleeveless_jacket_vest
	name = "sleeveless jacket vest"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/sleeveless

/datum/category_item/crafting/sewing_machine/leather/black_vest
	name = "black vest"
	path = /obj/item/clothing/suit/storage/leather_jacket_alt

/datum/category_item/crafting/sewing_machine/leather/nt_coat
	name = "nanotrasen coat"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/nanotrasen

/datum/category_item/crafting/sewing_machine/leather/nt_coat/sleeveless
	name = "sleeveless nanotrasen coat"
	path = /obj/item/clothing/suit/storage/toggle/leather_jacket/nanotrasen/sleeveless

/datum/category_item/crafting/sewing_machine/leather/bomberjacket
	name = "bomber jacket"
	path = /obj/item/clothing/suit/storage/toggle/bomber
	force_matter = list("leather" = 2000, "wool" = 400)

/datum/category_item/crafting/sewing_machine/leather/bomberjacket/alt
	name = "bomber jacket"
	path = /obj/item/clothing/suit/storage/bomber/alt
	force_matter = list("leather" = 2100, "wool" = 500)

/datum/category_item/crafting/sewing_machine/leather/wintercoat
	name = "winter coat"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat
	force_matter = list("leather" = 2600, "wool" = 700)

/datum/category_item/crafting/sewing_machine/leather/greyjacket
	name = "grey jacket"
	path = /obj/item/clothing/suit/storage/greyjacket

/datum/category_item/crafting/sewing_machine/leather/brownjacket
	name = "brown jacket"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket

/datum/category_item/crafting/sewing_machine/leather/brownjacket/vest
	name = "brown jacket vest"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket/sleeveless

/datum/category_item/crafting/sewing_machine/leather/brownjacket/nt
	name = "brown nanotrasen jacket"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen

/datum/category_item/crafting/sewing_machine/leather/brownjacket/nt/sleeveless
	name = "brown sleeveless nanotrasen jacket"
	path = /obj/item/clothing/suit/storage/toggle/brown_jacket/nanotrasen/sleeveless

// under garments

/datum/category_item/crafting/sewing_machine/leather/pants
	name = "pants"
	path = /obj/item/clothing/under/pants/leather

/datum/category_item/crafting/sewing_machine/leather/chaps
	name = "brown chaps"
	path = /obj/item/clothing/under/pants/chaps

/datum/category_item/crafting/sewing_machine/leather/chaps/black
	name = "black chaps"
	path = /obj/item/clothing/under/pants/chaps/black

// accessories
/datum/category_item/crafting/sewing_machine/leather/gloves
	name = "gloves"
	path = /obj/item/clothing/gloves/botanic_leather
	force_matter = list("leather" = 900)
// shoes
/datum/category_item/crafting/sewing_machine/leather/shoes
	name = "leather shoes"
	path = /obj/item/clothing/shoes/leather
	force_matter = list("leather" = 900)
	prefix = null

/datum/category_item/crafting/sewing_machine/leather/shoes/laceup
	name = "laceup shoes"
	path = /obj/item/clothing/shoes/laceup
	force_matter = list("leather" = 1300)

/datum/category_item/crafting/sewing_machine/leather/shoes/dress
	name = "dress shoes"
	path = /obj/item/clothing/shoes/dress
	force_matter = list("leather" = 1300)

/datum/category_item/crafting/sewing_machine/leather/shoes/dress/white
	name = "white dress shoes"
	path = /obj/item/clothing/shoes/dress/white
	force_matter = list("leather" = 1300)

/datum/category_item/crafting/sewing_machine/leather/shoes/skater
	name = "skater shoes"
	path = /datum/gear/shoes/skater
	force_matter = list("leather" = 1300, "cotton" = 200)

/datum/category_item/crafting/sewing_machine/leather/shoes/athletic
	name = "athletic shoes"
	path = /obj/item/clothing/shoes/athletic
	force_matter = list("leather" = 1300, "cotton" = 200)

/datum/category_item/crafting/sewing_machine/leather/shoes/heels
	name = "heels"
	path = /obj/item/clothing/shoes/heels
	force_matter = list("leather" = 850)

/datum/category_item/crafting/sewing_machine/leather/shoes/heels/long
	name = "long high heels"
	path = /obj/item/clothing/shoes/heels/long
	force_matter = list("leather" = 1000)

/datum/category_item/crafting/sewing_machine/leather/shoes/cowboy
	name = "cowboy boots"
	path = /obj/item/clothing/shoes/boots/cowboy
	force_matter = list("leather" = 1900)

/datum/category_item/crafting/sewing_machine/leather/shoes/cowboy/classic
	name = "classic cowboy boots"
	path = /obj/item/clothing/shoes/boots/cowboy/classic
	force_matter = list("leather" = 1900)

/datum/category_item/crafting/sewing_machine/leather/shoes/cowboy/snakeskin
	name = "snakeskin cowboy boots"
	path = /obj/item/clothing/shoes/boots/cowboy/snakeskin
	force_matter = list("leather" = 1900)

/datum/category_item/crafting/sewing_machine/leather/shoes/jungle
	name = "jungle boots"
	path = /obj/item/clothing/shoes/boots/jungle
	force_matter = list("leather" = 1900)

/datum/category_item/crafting/sewing_machine/leather/shoes/duty
	name = "duty boots"
	path = /obj/item/clothing/shoes/boots/duty
	force_matter = list("leather" = 2000)

/datum/category_item/crafting/sewing_machine/leather/shoes/duty
	name = "winter boots"
	path = /obj/item/clothing/shoes/boots/winter
	force_matter = list("leather" = 2000, "wool" = 2000)


/datum/category_item/crafting/sewing_machine/leather/shoes/stylish
	name = "brown stylish boots"
	path = /obj/item/clothing/shoes/boots/stylish
	force_matter = list("leather" = 2000, "cotton" = 200)


/datum/category_item/crafting/sewing_machine/leather/shoes/stylish/charcoal
	name = "charcoal stylish boots"
	path = /obj/item/clothing/shoes/boots/stylish/charcoal

/datum/category_item/crafting/sewing_machine/leather/shoes/stylish/navy
	name = "navy stylish boots"
	path = /obj/item/clothing/shoes/boots/stylish/navy

/datum/category_item/crafting/sewing_machine/leather/shoes/stylish/red
	name = "red stylish boots"
	path = /obj/item/clothing/shoes/boots/stylish/red

/datum/category_item/crafting/sewing_machine/leather/shoes/stylish/silver
	name = "silver stylish boots"
	path = /obj/item/clothing/shoes/boots/stylish/silver

// bags

/datum/category_item/crafting/sewing_machine/leather/bag
	name = "chemistry bag"
	path = /obj/item/weapon/storage/bag/chemistry

	prefix = null
	force_matter = list("leather" = 4000)

/datum/category_item/crafting/sewing_machine/leather/bag/food
	name = "food bag"
	path = /obj/item/weapon/storage/bag/food
	force_matter = list("leather" = 4000)
/datum/category_item/crafting/sewing_machine/leather/bag/fossil
	name = "fossil bag"
	path = /obj/item/weapon/storage/bag/fossils
	force_matter = list("leather" = 4000)
/datum/category_item/crafting/sewing_machine/leather/bag/ore
	name = "ore bag"
	path = /obj/item/weapon/storage/bag/ore
	force_matter = list("leather" = 4000)
/datum/category_item/crafting/sewing_machine/leather/bag/plant
	name = "plant bag"
	path = /obj/item/weapon/storage/bag/plants
	force_matter = list("leather" = 4000)
/datum/category_item/crafting/sewing_machine/leather/bag/xenobio
	name = "xenobio bag"
	path = /obj/item/weapon/storage/bag/xenobio
	force_matter = list("leather" = 4000)
/datum/category_item/crafting/sewing_machine/leather/bag/clothing
	name = "clothing bag"
	path = /obj/item/weapon/storage/bag/clothing
	force_matter = list("leather" = 4000)
/datum/category_item/crafting/sewing_machine/leather/bag/sheet
	name = "sheet snatcher"
	path = /obj/item/weapon/storage/bag/sheetsnatcher
	force_matter = list("leather" = 4000)


// other bags
/datum/category_item/crafting/sewing_machine/leather/santabag
	name = "santa bag"
	path = /obj/item/weapon/storage/backpack/santabag/normal
	force_matter = list("leather" = 3000)

/datum/category_item/crafting/sewing_machine/leather/satchel
	name = "satchel"
	path = /obj/item/weapon/storage/backpack/satchel
	force_matter = list("leather" = 5000)


// belts

/datum/category_item/crafting/sewing_machine/leather/belt
	name = "utility belt"
	path = /obj/item/weapon/storage/belt/utility
	force_matter = list("leather" = 2500)

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack
	name = "fannypack"
	path = /obj/item/weapon/storage/belt/fannypack
	prefix = null

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/black
	name = "black fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/black

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/blue
	name = "blue fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/blue

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/cyan
	name = "cyan fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/cyan

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/green
	name = "green fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/green

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/orange
	name = "orange fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/orange

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/purple
	name = "purple fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/purple

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/red
	name = "red fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/red

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/white
	name = "white fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/white

/datum/category_item/crafting/sewing_machine/leather/belt/fannypack/yellow
	name = "yellow fannypack"
	path = /obj/item/weapon/storage/belt/fannypack/yellow

// wallets

/datum/category_item/crafting/sewing_machine/leather/wallet
	name = "wallet"
	path = /obj/item/weapon/storage/wallet

/datum/category_item/crafting/sewing_machine/leather/wallet/womens
	name = "women's wallet"
	path = /obj/item/weapon/storage/wallet/womens

// pouches


/datum/category_item/crafting/sewing_machine/leather/pouch
	name = "pouch"
	path = /obj/item/clothing/accessory/storage/pouches

/datum/category_item/crafting/sewing_machine/leather/pouch/blue
	name = "pouch (blue)"
	path = /obj/item/clothing/accessory/storage/pouches/blue

/datum/category_item/crafting/sewing_machine/leather/pouch/green
	name = "pouch (green)"
	path = /obj/item/clothing/accessory/storage/pouches/green

/datum/category_item/crafting/sewing_machine/leather/pouch/tan
	name = "pouch (tan)"
	path = /obj/item/clothing/accessory/storage/pouches/tan

/datum/category_item/crafting/sewing_machine/leather/pouch/navy
	name = "pouch (navy)"
	path = /obj/item/clothing/accessory/storage/pouches/navy

/datum/category_item/crafting/sewing_machine/leather/pouch/large
	name = "pouch (large)"
	path = /obj/item/clothing/accessory/storage/pouches/large

/datum/category_item/crafting/sewing_machine/leather/pouch/large/blue
	name = "pouch (large - blue)"
	path = /obj/item/clothing/accessory/storage/pouches/large/blue

/datum/category_item/crafting/sewing_machine/leather/pouch/large/green
	name = "pouch (large - green)"
	path = /obj/item/clothing/accessory/storage/pouches/large/green

/datum/category_item/crafting/sewing_machine/leather/pouch/large/navy
	name = "pouch (large - navy)"
	path = /obj/item/clothing/accessory/storage/pouches/large/navy

/datum/category_item/crafting/sewing_machine/leather/pouch/large/tan
	name = "pouch (large - tan)"
	path = /obj/item/clothing/accessory/storage/pouches/large/tan


// webbing / holsters

/datum/category_item/crafting/sewing_machine/leather/webbing
	name = "webbing"
	path = /obj/item/clothing/accessory/storage/webbing

/datum/category_item/crafting/sewing_machine/leather/holster
	name = "holster"
	path = /obj/item/clothing/accessory/holster

/datum/category_item/crafting/sewing_machine/leather/holster/armpit
	name = "armpit holster"
	path = /obj/item/clothing/accessory/holster/armpit

/datum/category_item/crafting/sewing_machine/leather/holster/hip
	name = "hip holster"
	path = /obj/item/clothing/accessory/holster/hip

/datum/category_item/crafting/sewing_machine/leather/holster/leg
	name = "leg holster"
	path = /obj/item/clothing/accessory/holster/leg

/datum/category_item/crafting/sewing_machine/leather/holster/waist
	name = "waist holster"
	path = /obj/item/clothing/accessory/holster/waist