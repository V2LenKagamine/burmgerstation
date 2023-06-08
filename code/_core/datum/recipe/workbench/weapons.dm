/recipe/workbench/shuriken

	name = "shuriken"

	required_item_and_amount = list(
		/obj/item/material/rod/steel = 4
	)
	product = /obj/item/weapon/ranged/thrown/shuriken
	amount = 10
/* Todo : Figure out how to make non-stacking items work with new non-grid crafting...
/recipe/workbench/kitchen_shuriken

	name = "kitchen shuriken"

	required_item_and_amount = list(
		/obj/item/weapon/melee/sword/chef_knife = 4
	)

	product = /obj/item/weapon/ranged/thrown/kitchen_shuriken
	amount = 10
*/
/recipe/workbench/bootleg_landmine

	name = "landmine bootleg"

	required_item_and_amount = list(
		/obj/item/device/proximity = 1,
		/obj/item/weapon/melee/tool/screwdriver = 0,
		/obj/item/grenade/timed/explosive = 1
	)

	product = /obj/item/grenade/landmine/proximity/explosive
