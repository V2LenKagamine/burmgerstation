/recipe/bullet_press/incen
	name = "incen base"
	desc = "base recipe for incen rounds"
	desc_extended = "bullet press recipe description"

/recipe/bullet_press/incen/shotgun_23
	name = "shotgun 23 incen"

	required_item_and_amount = list(
		/obj/item/material/pellets/magnesium = 4,
		/obj/item/bullet_cartridge/shotgun_23/ = 1
	)

	product = /obj/item/bullet_cartridge/shotgun_23/fire

/recipe/bullet_press/incen/shotgun_12
	name = "shotgun 12 incen"

	required_item_and_amount = list(
		obj/item/material/pellets/magnesium = 2,
		/obj/item/bullet_cartridge/shotgun_12 = 1
	)

	product = /obj/item/bullet_cartridge/shotgun_12/fire

/recipe/bullet_press/incen/sniper_50
	name = "sniper 50 incen"

	required_item_and_amount = list(
		/obj/item/material/pellets/magnesium = 32
		/obj/item/crafting/ingredient/part/gunpowder= 40,
		/obj/item/crafting/ingredient/part/bullet_casings = 8,
		/obj/item/magazine/sniper_50 = 1
	)

	product = /obj/item/magazine/sniper_50/incendiary
	required_item_grid_amount = list()
