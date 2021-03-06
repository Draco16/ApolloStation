/obj/item/weapon/gun/energy/taser
	name = "taser gun"
	desc = "A small, low capacity gun used for non-lethal takedowns."
	icon_state = "taser"
	item_state = null	//so the human update icon uses the icon_state instead.
	fire_sound = 'sound/weapons/Taser.ogg'
	charge_cost = 100
	projectile_type = "/obj/item/projectile/beam/stun"
	cell_type = "/obj/item/weapon/cell/crap"

/obj/item/weapon/gun/energy/taser/cyborg
	cell_type = "/obj/item/weapon/cell/secborg"
	var/charge_tick = 0
	var/recharge_time = 10 //Time it takes for shots to recharge (in ticks)

	New()
		..()
		processing_objects.Add(src)


	Destroy()
		processing_objects.Remove(src)
		..()

	process() //Every [recharge_time] ticks, recharge a shot for the cyborg
		charge_tick++
		if(charge_tick < recharge_time) return 0
		charge_tick = 0

		if(!power_supply) return 0 //sanity
		if(power_supply.charge >= power_supply.maxcharge) return 0 // check if we actually need to recharge

		if(isrobot(src.loc))
			var/mob/living/silicon/robot/R = src.loc
			if(R && R.cell)
				R.cell.use(charge_cost) 		//Take power from the borg...
				power_supply.give(charge_cost)	//... to recharge the shot

		update_icon()
		return 1


/obj/item/weapon/gun/energy/stunrevolver
	name = "stun revolver"
	desc = "A high-tech revolver that fires stun cartridges. The stun cartridges can be recharged using a conventional energy weapon recharger."
	icon_state = "stunrevolver"
	fire_sound = 'sound/weapons/Taser.ogg'
	origin_tech = "combat=3;materials=3;powerstorage=2"
	charge_cost = 125
	projectile_type = "/obj/item/projectile/beam/stun"
	cell_type = "/obj/item/weapon/cell"



/obj/item/weapon/gun/energy/crossbow
	name = "mini energy-crossbow"
	desc = "A weapon favored by many mercenary stealth specialists."
	icon_state = "crossbow"
	w_class = 2.0
	item_state = "crossbow"
	matter = list("metal" = 2000, "uranium" = 100)
	origin_tech = "combat=2;magnets=2;syndicate=5"
	silenced = 1
	charge_cost = 250
	fire_sound = 'sound/weapons/Genhit.ogg'
	projectile_type = "/obj/item/projectile/energy/bolt"
	cell_type = "/obj/item/weapon/cell/crap"
	var/charge_tick = 0
	var/charge_rate = 250
	var/charge_time = 30

	New()
		..()
		processing_objects.Add(src)


	Destroy()
		processing_objects.Remove(src)
		..()


	process()
		charge_tick++
		if(charge_tick < charge_time) return 0
		charge_tick = 0
		if(!power_supply) return 0
		power_supply.give(charge_rate)
		return 1


	update_icon()
		return

/obj/item/weapon/gun/energy/crossbow/ninja
	name = "energy dart thrower"
	projectile_type = "/obj/item/projectile/energy/dart"

/obj/item/weapon/gun/energy/crossbow/largecrossbow
	name = "Energy Crossbow"
	desc = "A weapon favored by mercenary infiltration teams."
	w_class = 4.0
	force = 10
	matter = list("metal" = 200000)
	projectile_type = "/obj/item/projectile/energy/bolt/large"
