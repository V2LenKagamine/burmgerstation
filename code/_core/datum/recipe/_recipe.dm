/recipe/

	var/name = "recipe"
	var/recipe_type = ""

	var/desc = "A recipe."
	var/desc_extended = "Recipe information."

	var/do_debug = FALSE

	var/list/required_item_and_amount = list() //Item = amount consumed. Item = 0 means item is required, but not consumed.

	var/list/product_reagents = list() //Reagent to fill resulting container with, if any. Reagent = amount, Doesnt check if the container can HOLD that much though, so it can overfill.

	var/obj/item/product //The created product.
	var/product_amount = 1 //The amount of products to create.

	var/secret = FALSE //Its a secret to everybody. Won't show up in "recipe" loot items.

/recipe/proc/on_create(var/mob/living/advanced/caller,var/obj/item/crafting/crafting_table,var/obj/item/created_item,var/list/item_table)

	//By default, remove all the items.
	for(var/j in item_table)
		var/obj/item/I = j
		var/amount_to_remove = required_item_and_amount[I]
		if(I.reagents && created_item.reagents)
			I.reagents.transfer_reagents_to(created_item.reagents)
		if(amount_to_remove > 0)
			I.add_item_count(-amount_to_remove)

	return TRUE

/recipe/proc/check_recipe(var/list/item_table,var/obj/item/crafting/crafting_table) //Returns items that were used in creation. Return null if fail.

	if(!length(item_table))
		return null

	var/list/used_items = list()

	for(var/item in required_item_and_amount)

		var/needed_amount = required_item_and_amount[item]
		var/obj/item/I = item_table[item]
		if(!I)
			if(do_debug) log_debug("There is no [item] in the crafting table. We cannot craft this recipe ([name]) without a(n) [item].")
			return null

		if(I.amount < needed_amount)
			if (do_debug) log_debug("Not enough [item] in table! We need [needed_amount]!")
			return null
		used_items[I] = needed_amount

	return used_items
