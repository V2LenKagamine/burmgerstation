/obj/hud/button/squad/main
	name = "squad button"
	desc = "We ARMA now."
	desc_extended = "Press this button to open the squad menu."
	icon = 'icons/hud/new.dmi'
	icon_state = "squad"
	screen_loc = "LEFT,TOP-2"

	flags = FLAGS_HUD_MOB

	alpha = 100

/obj/hud/button/squad/main/update_icon()

	if(owner && is_player(owner))
		var/mob/living/advanced/player/P = owner
		if(P.current_squad && alpha != 255)
			animate(src,alpha = 255,time=10)
		else if(!P.current_squad && alpha != 100)
			animate(src,alpha = 100,time=10)

	return ..()

/obj/hud/button/squad/main/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller))
		return ..()

	var/mob/living/advanced/player/P = caller

	spawn()
		if(length(all_squads))

			var/list/squad_table = list()

			squad_table["Create New Squad"] = "Create New Squad"

			if(P.current_squad)
				squad_table["Leave Existing Squad"] = "Leave Existing Squad"

			for(var/squad/S in all_squads)
				var/name_format = "[S.name] ([length(S.members)]/[SQUAD_MEMBERS_MAX])"
				squad_table[name_format] = S

			var/answer = input("Which squad would you like to join?","Squad Selection",null) as null|anything in squad_table

			if(!P)
				return FALSE

			if(P.current_squad && answer == "Leave Existing Squad")
				P.current_squad.remove_member(P)
				return ..()

			else if(answer == "Create New Squad")
				new_squad(P)
				return ..()

			else if(answer != "Cancel")
				var/squad/S = squad_table[answer]
				S.add_member(P)
				update_icon()

		else
			var/answer = input("There aren't any squads available to join. Would you like to create a squad?","Squad Creation","Cancel") in list("Yes","No","Cancel")
			if(answer == "Yes")
				new_squad(P)

	return ..()

/obj/hud/button/squad/main/proc/new_squad(var/mob/living/advanced/player/P)
	while(P.client)
		var/squad_name = input("Please enter your squad name. Enter nothing to cancel.","Squad Creation",null) as text|null

		if(squad_name == "Cancel" || squad_name == "Create New Squad")
			P.to_chat("You cheeky bastard.")
			return FALSE

		if(!squad_name)
			return FALSE

		var/found_name = FALSE
		for(var/squad/S in all_squads)
			if(S.name == squad_name)
				found_name = TRUE

		if(found_name)
			P.to_chat("That name is already taken!")
			continue

		var/squad/S = new
		S.name = squad_name
		S.add_member(P)
		S.set_leader(P)
		update_icon()
		return TRUE

/obj/hud/button/squad/member
	name = "squad member button"
	desc = "Represents a squad member."

	icon = 'icons/hud/progress.dmi'
	icon_state = "progress"

	maptext = "Name Here"
	maptext_width = TILE_SIZE*3
	maptext_y = 8

	screen_loc = "CENTER,CENTER"

	var/health_current = 100
	var/health_max = 100

	var/mob/living/advanced/player/tracked_mob

/obj/hud/button/squad/member/Destroy()
	tracked_mob = null
	return ..()

/obj/hud/button/squad/member/New(var/desired_loc,var/desired_tracked_mob)
	var/icon/I = new(icon,icon_state)
	swap_colors(I)
	underlays += I
	tracked_mob = desired_tracked_mob
	return ..()

/obj/hud/button/squad/member/update_icon()

	maptext = tracked_mob.name

	if(tracked_mob && tracked_mob.health)
		var/desired_num = FLOOR((tracked_mob.health.health_current/tracked_mob.health.health_max) * 26, 1)
		icon_state = "bar_[desired_num]"

	return ..()