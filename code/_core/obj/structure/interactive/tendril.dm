var/global/list/possible_monsters_to_spawn = list(
	/mob/living/simple/legionare_head,
	/mob/living/simple/goliath,
	/mob/living/simple/hivelord,
	/mob/living/simple/watcher
)

var/global/list/possible_bosses_to_spawn = list(
	/mob/living/simple/ash_drake,
	/mob/living/simple/bubblegum,
	/mob/living/simple/colossus,
	/mob/living/simple/goliath/broodmother
)



/obj/structure/interactive/tendril
	name = "tendril"
	desc = "The source of all life in lavaland."
	desc_extended = "A very dangerous tendril that creates life, as well as destroys it. Exhausting the life of the tendril may result in unforseen consequences..."

	icon = 'icons/obj/structure/tendril.dmi'
	icon_state = "idle"

	var/mob/living/monster_to_spawn
	var/spawn_limit = 4
	var/list/mob/living/tracked_mobs = list()

	var/mob/living/boss_to_spawn

	var/deaths_until_boss = 20

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	density = TRUE

	anchored = 2

	pixel_y

	desired_light_power = 0.75
	desired_light_range = VIEW_RANGE*0.5
	desired_light_color = "#C67000"

	plane = PLANE_SCENERY

/obj/structure/interactive/tendril/Destroy()
	. = ..()
	tracked_mobs.Cut()

/obj/structure/interactive/tendril/Generate()
	. = ..()
	if(!monster_to_spawn)
		monster_to_spawn = pick(possible_monsters_to_spawn)

	if(!boss_to_spawn)
		boss_to_spawn = pick(possible_bosses_to_spawn)

/obj/structure/interactive/tendril/Finalize()
	. = ..()
	CALLBACK("\ref[src]_spawn",SECONDS_TO_DECISECONDS(2),src,.proc/spawn_monster)

/obj/structure/interactive/tendril/proc/telegraph_delete()

	for(var/k in DIRECTIONS_ALL + 0x0)
		var/turf/T = get_step(src,k)
		if(is_simulated(T))
			var/turf/simulated/S = T
			if(S.health)
				S.change_turf(/turf/simulated/liquid/lava/)

	if(boss_to_spawn)
		var/turf/T = get_turf(src)
		var/mob/living/L = new boss_to_spawn(T)
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)
		if(L.ai) L.ai.set_active(TRUE)
		var/obj/effect/temp/E = new(T,SECONDS_TO_DECISECONDS(1))
		E.plane = PLANE_JUNK
		E.layer = 1000
		E.icon = 'icons/obj/effects/ash_drake_landing.dmi'
		E.icon_state = "landing"
		E.pixel_x = -TILE_SIZE
		E.pixel_y = -TILE_SIZE
		L.color = "#000000"
		animate(L,color=initial(L.color),SECONDS_TO_DECISECONDS(1))
		boss_to_spawn = null

	qdel(src)

/obj/structure/interactive/tendril/proc/spawn_monster()

	if(src.qdeleting)
		return FALSE

	for(var/k in tracked_mobs)
		var/mob/living/L = k
		if(L.qdeleting || L.dead)
			tracked_mobs -= L
			deaths_until_boss -= 1

	var/tracked_mobs_length = length(tracked_mobs)

	if(tracked_mobs_length <= 0 && deaths_until_boss <= 0)
		alpha = 0
		set_density(0)
		play_sound('sound/effects/tendril_destroyed.ogg',get_turf(src))
		CALLBACK("\ref[src]_telegraph_delete",SECONDS_TO_DECISECONDS(4),src,.proc/telegraph_delete)
		return TRUE

	if(tracked_mobs_length < spawn_limit)

		var/list/valid_turfs = list()
		for(var/d in DIRECTIONS_ALL)
			var/turf/T2 = get_step(src,d)
			if(T2 && !T2.density && T2.is_safe_move())
				valid_turfs += T2

		if(length(valid_turfs))
			var/turf/T2 = pick(valid_turfs)
			var/mob/living/L = new monster_to_spawn(T2)
			INITIALIZE(L)
			GENERATE(L)
			FINALIZE(L)
			tracked_mobs += L
			var/obj/effect/temp/E = new(T2,SECONDS_TO_DECISECONDS(1))
			E.icon = 'icons/obj/effects/tendril_spawn.dmi'
			E.icon_state = "spawning"
			L.color = "#000000"
			animate(L,color=initial(L.color),SECONDS_TO_DECISECONDS(1))
			if(L.ai) L.ai.set_active(TRUE)
			flick("spawn",src)



	CALLBACK("\ref[src]_spawn",SECONDS_TO_DECISECONDS(2+tracked_mobs_length),src,.proc/spawn_monster)

	return TRUE