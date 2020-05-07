/material/stone/concrete
	name = MATERIAL_CONCRETE
//	lore_text = "The most ubiquitous building material of old Earth, now in space. Consists of mineral aggregate bound with some sort of cementing solution."
//	stack_type = /obj/item/stack/material/generic/brick
	icon_colour = COLOR_GRAY
	var/image/texture

/material/stone/concrete/New()
	..()
	texture = image('icons/turf/wall_texture.dmi', "concrete")
	texture.blend_mode = BLEND_MULTIPLY

/material/stone/concrete/get_wall_texture()
	return texture