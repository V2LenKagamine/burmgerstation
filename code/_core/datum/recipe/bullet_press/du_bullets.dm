/recipe/bullet_press/du
	name = "depleted uranium base"
	desc = "base recipe for du rounds"
	desc_extended = "bullet press recipe description"

/recipe/bullet_press/du/rifle_308
	name = "depleted uranium 308"

	required_item_and_amount = list(
		/obj/item/material/pellets/uranium_235 = 40,
		/obj/item/crafting/ingredient/part/gunpowder = 40,
		/obj/item/magazine/rifle_308 = 1,
		/obj/item/crafting/ingredient/part/bullet_casings = 40
	)

	product = /obj/item/magazine/rifle_308/du


/recipe/bullet_press/du/nuke
	name = "depleted uranium nuke"

	required_item_and_amount = list(
		/obj/item/material/ingot/uranium_235 = 5,
		/obj/item/crafting/ingredient/part/gunpowder = 25,
		/obj/item/bullet_cartridge/rocket_70mm = 1
	)

	product = /obj/item/bullet_cartridge/rocket_70mm/nuclear

/recipe/bullet_press/du/rifle_50
	name = "depleted uranium 50"


	required_item_and_amount = list(
		/obj/item/material/pellets/uranium_235 =16,
		/obj/item/crafting/ingredient/part/gunpowder =32,
		/obj/item/crafting/ingredient/part/bullet_casings =8,
		/obj/item/magazine/sniper_50 = 1
	)

	product = /obj/item/magazine/sniper_50/du

/recipe/bullet_press/du/rifle_308_nato
	name = "depleted uranium 308 nato"

	required_item_and_amount = list(
		/obj/item/material/pellets/uranium_235 = 30,
		/obj/item/crafting/ingredient/part/gunpowder = 30,
		/obj/item/crafting/ingredient/part/bullet_casings = 30,
		/obj/item/magazine/sniper_308/nato = 1
	)

	product = /obj/item/magazine/sniper_308/nato/du

/recipe/bullet_press/du/sniper_127
	name = "depleted uranium 127 sniper"

	required_item_grid = list(
		"a2" = "/obj/item/material/pellets/uranium_235",

		"b2" = "/obj/item/crafting/ingredient/part/gunpowder",
		"b3" = "/obj/item/magazine/sniper_127",

		"c2" = "/obj/item/crafting/ingredient/part/bullet_casings"
	)

	required_item_and_amount = list(
		/obj/item/material/pellets/uranium_235 = 16,
		/obj/item/crafting/ingredient/part/gunpowder = 12,
		/obj/item/crafting/ingredient/part/bullet_casings = 8,
		/obj/item/magazine/sniper_127 = 1
	)

	product = /obj/item/magazine/sniper_127/du

/recipe/bullet_press/du/sniper_20
	name = "depleted uranium 20 sniper"

	required_item_and_amount = list(
		/obj/item/material/pellets/uranium_235 = 32,
		/obj/item/crafting/ingredient/part/gunpowder = 64,
		/obj/item/crafting/ingredient/part/bullet_casings = 4,
		/obj/item/magazine/sniper_20mm = 1
	)

	product = /obj/item/magazine/sniper_20mm/du

/recipe/bullet_press/du/minigun_46
	name = "depleted uranium minigun_46"

	required_item_and_amount = list(
		/obj/item/material/pellets/uranium_235 = 100,
		/obj/item/crafting/ingredient/part/gunpowder = 50,
		/obj/item/magazine/minigun_46 = 1
	)

	product = /obj/item/magazine/minigun_46/du
