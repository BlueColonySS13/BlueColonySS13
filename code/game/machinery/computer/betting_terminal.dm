/obj/machinery/computer/betting_terminal
	name = "horse racing terminal"
	desc = "A betting terminal synced to the Horse Racing Association's database."
	icon = 'icons/obj/machines/betting_terminal.dmi'
	icon_state = "horse0"
	anchored = 1

	var/id = 0
	var/datum/money_account/our_money_account

	var/rigged = 0
	var/betting = 0
	var/bet_cost = 100
	var/bet_type = 1
/*****
 *		BET TYPES:
 *	1 - WIN - The chosen horse must come in first place to win.
 *	2 - PLACE - The chosen horse muse come in first or second place to win.
 *	3 - SHOW - The chosen horse must come in first, second, or third place to win.
 *****/


	var/stored_money = 0 //Cash

	var/value_1 = 1
	var/chosen = ""


/obj/machinery/computer/betting_terminal/New()
	.=..()

	id = rand(1,99999)

	our_money_account = create_account("horse racing terminal ([id])", rand(50000,70000))

	update_icon()

/obj/machinery/computer/betting_terminal/proc/get_bet_cost()
	return get_item_cost()

/obj/machinery/computer/betting_terminal/get_item_cost()
	return bet_cost

/obj/machinery/computer/betting_terminal/get_tax()
	return GAMBLING_TAX

/obj/machinery/computer/betting_terminal/update_icon()
	..()
	var/initial_icon = initial(icon_state)

	if(stat & BROKEN)
		icon_state = "horseb"
	else if(stat & NOPOWER)
		icon_state = "horse0"
	else
		icon_state = initial_icon

/obj/machinery/computer/betting_terminal/proc/speak(var/message)
	if(stat & NOPOWER)
		return

	if(!message)
		return

	for(var/mob/O in hearers(src, null))
		O.show_message("<span class='game say'><span class='name'>\The [src]</span> beeps, \"[message]\"</span>",2)
	return

/obj/machinery/computer/betting_terminal/proc/cast_bet(win = -1) //If win=-1, the result is pure randomness. If win=0, you NEVER win. If win is 1 to 10, you win.
	while(1)
		value_1 = rand(1,7)

		switch(win)
			if(-1)
				return //Pure randomness!
			if(3 to 7)
				value_1 = win
				return
			else
				return

/obj/machinery/computer/betting_terminal/proc/bet(mob/user)
	if(betting) return

	//Charge money:
	if(stored_money >= bet_cost) //If there's cash in the machine
		stored_money -= bet_cost
		department_accounts["[station_name()] Funds"].money += post_tax_cost()
	else
		return

	betting = 1
	icon_state = "horse1"

	var/loop_count = 0
	var/list/horses = list()
	var/horse_name = ""

	//populate horses in the race - select 7
	while(loop_count < 7)
		horse_name = pick("Treasure", "Fleetlight", "Lord Kaine", "Joestar", "Pietro the Cuban", "Charm", "Annabel", "Jazzy", "Snowball", "Romeo", "Duke", "Elizabeth",
		"Butt Stallion", "Karana", "Joye", "Mac", "Jeff", "Abacchio", "Morning Sparks", "Miles", "Fiddler", "Sugar", "Willow", "Sapphire", "Midnightfeet", "Lincoln",
		"Flightsilver", "Archie", "Morningheart", "Barkley", "Thunder Step", "Landslide", "DIO", "Andrejana", "Sugarpuff", "Twilight Sparkle", "Vixen", "Red Baron", "Flash Forward",
		"Red Racer", "Accelerator", "Polnareff", "Altair", "Oblivion", "Uniquess", "Paladine", "Carver", "Gatsby", "Chauncey", "Storm Blossom", "G.T. Melons", "Mr. Pibbs",
		"Moonheart", "Scarlette", "Triggerfeet", "Nelson", "Rusty", "Baloo", "Highlight", "Xiao", "Pescao", "Falcor", "Gallow", "Gallena", "Faux", "Bama", "La Roux", "Humblebottom",
		"Noble Stallion", "Bayjour", "Nanook", "Mustang", "Shirley", "Snipper", "Heap", "Sky", "Level", "Hawk", "Eternal","Creole", "Rain Ranger", "Starduster", "Bear", "Sisco",
		"Sizzler", "Brocco", "Ledger", "Charmcaster", "Tennyson", "Bezel")

		horses += horse_name
		loop_count += 1

	//Choose a horse
	chosen = input(usr, "Choose a horse to bet on.", "Horse Betting") in horses

	//Set bet type
	switch(alert("Which type of bet would you like to place?\nWIN - The chosen horse must come in first place to win.\nPLACE - The chosen horse must come in first or second place to win.\nSHOW - The chosen horse must come in first, second, or third place to win.", "Bet Type", "Win", "Place", "Show"))
		if("Win")
			bet_type = 1
		if("Place")
			bet_type = 2
		if("Show")
			bet_type = 3

	//Set amount to bet
	var/new_bet_cost = input(user,"How many credits would you like to place on this bet?", "Bet Amount", bet_cost) as null|num

	if(!isnull(new_bet_cost) && (new_bet_cost <= stored_money))
		if(new_bet_cost < 100)
			speak("Your bet amount is less than the minimum amount of 100 credits and has automatically been raised.")
			bet_cost = 100
		else if(new_bet_cost > 1000)
			speak("Your bet amount is greater than the maximum amount of 1000 credits and has automatically been lowered.")
			bet_cost = 1000
		else
			bet_cost = new_bet_cost

	//Pre-calculate results
	if(rigged)
		value_1 = 1
		rigged = 0

	else
		var/victory = rand(1,50)

		switch(victory)
			if(1) //1 in 20 for a guaranteed small reward
				cast_bet(win = rand(3,7))
			if(2 to 50) //Otherwise, a fully random bet (1/1000 to get jackpot, 1/100 to get other reward)
				cast_bet(win = -1)

	playsound(get_turf(src),'sound/effects/horse_race.ogg',30,-4)
	speak(pick("The horses are out of the gate at lightning speed!", "We're off to a good start! Look at those fine stallions move!",
	"The crowd is riled up! This is sure to be a race for the history books!", "The horses are out! The crowd is chanting [horse_name]'s name!"))
	sleep(50)

	playsound(get_turf(src),'sound/effects/horses_running.ogg',50,-4)
	speak(pick("Look at them go! It's sure to be a photo-finish!", "Wow! [horse_name] is barrelling through the lanes!", "Such speed! This is going to be a good race!",
	"[horse_name] just might have a chance at placing in the top three!", "It looks like some of the observers are nervous... It looks like their pick isn't doing so well!",
	"They're half-way around the bend now! It's almost over!", "The tension is so thick you could cut it with a knife!"))
	sleep(41)

	speak(pick("Wow! What an ending!", "And it's over! It looks like...", "A photo-finish! Let's see what the judges have to say!",
	"[horse_name] is a fan favorite and the crowds made sure we knew it during the race but it's over now!"))
	sleep(41)

	check_victory(user)

	betting = 0
	icon_state = "horse0"

/obj/machinery/computer/betting_terminal/proc/check_victory(mob/user)
	if(!our_money_account)
		return

	if(value_1 <= 7)

		var/win_value = 0

		switch(value_1)

			if(1)
				if(bet_type == 1)
					win_value = round(2 * bet_cost)
				else if(bet_type == 2)
					win_value = round(1.75 * bet_cost)
				else
					win_value = round(1.5 * bet_cost)
				speak("[chosen] came in first place!")
			if(2)
				if(bet_type == 1)
					win_value = 0
				else
					win_value = round(1.25 * bet_cost)
				speak("[chosen] came in second place!")
			if(3)
				if(bet_type < 3)
					win_value = 0
				else
					win_value = round(1.1 * bet_cost)
				speak("[chosen] came in third place!")
			if(4)
				win_value = 0
				speak("[chosen] came in fourth place!")
			if(5)
				win_value = 0
				speak("[chosen] came in fifth place!")
			if(6)
				win_value = 0
				speak("[chosen] came in sixth place!")
			if(7)
				win_value = 0
				speak("[chosen] came in last!")

		if(win_value)
			win_value = min(win_value, our_money_account.money)

			spawn(10)
				if(our_money_account.charge(win_value,null,"Payout","horse racing terminal #[id]"))
					spawn_money(win_value,src.loc,usr)
					playsound(get_turf(src), "polaroid", 50, 1)

					user << "<span class='notice'>You win $[win_value]!</span>"
				else
					src.visible_message("<span class='danger'>[src]'s screen flashes red.</span>")

		sleep(50)

/obj/machinery/computer/betting_terminal/proc/hit_animation()
	var/init_px = pixel_x
	var/shake_dir = pick(-1, 1)
	animate(src, transform=turn(matrix(), 4 * shake_dir), pixel_x=init_px + 2 * shake_dir, time=1)
	animate(transform=null, pixel_x=init_px, time=6, easing=ELASTIC_EASING)


/obj/machinery/computer/betting_terminal/attack_hand(mob/user as mob)
	if(..())
		return

	if(!istype(user, /mob/living/silicon))
		if(user.a_intent == I_HURT)
			hit_animation()
			visible_message("<span class='danger'>[usr] aggressively kicks the [src] in pure frustration!</span>")

			playsound(user.loc, 'sound/weapons/gunshot4.ogg', 50, 1)
			add_fingerprint(user)
			return
		else
			user.set_machine(src)

			var/dat = {"<h4>Terminal Funds: <b>[our_money_account ? "$[num2septext(our_money_account.money)]" : "---ERROR---"]</b></h4><br>"}

			if(stored_money > 0)
				dat += {"There are <span style="color:[stored_money<bet_cost?"red":"green"]"><b>$[num2septext(stored_money)]</b>
					credits inserted. <span style="color:blue"><a href='?src=\ref[src];reclaim=1'>Reclaim</a></span><br>"}
			else
				dat += {"You need at least <b>$[bet_cost]</b> credits to play. Use a nearby ATM and retreive some cash from your money account!<br>"}

			if(can_play())
				if(stored_money >= bet_cost)
					dat += {"<span style="color:yellow"><a href='?src=\ref[src];bet=1'>Play! (<b>$[bet_cost]</b>)</a></span><br>"}

			else
				dat += {"<b>OUT OF SERVICE</b><br>"}

			var/datum/browser/popup = new(user, "bettingterminal", "[src]", 500, 300, src)
			popup.set_content(dat)
			popup.open()

			onclose(user, "bettingterminal")



/obj/machinery/computer/betting_terminal/Topic(href, href_list)
	if(..())
		return
	if(betting)
		return

	if(href_list["reclaim"])
		spawn_money(stored_money,src.loc,usr)
		stored_money = 0

	else if(href_list["bet"])
		if((stored_money >= 100) && can_play())
			bet(usr)

	src.updateUsrDialog()


/obj/machinery/computer/betting_terminal/attackby(obj/item/I as obj, mob/user as mob)
	..()

	if(istype(I,/obj/item/weapon/spacecash))
		if(!can_play())
			user << "<span class='notice'>[src] rejects your money.</span>"
			return

		var/obj/item/weapon/spacecash/S = I
		var/money_add = S.worth

		user.drop_item(I)
		qdel(I)

		src.stored_money += money_add
		src.updateUsrDialog()

/obj/machinery/computer/betting_terminal/proc/can_play() //If no money in OUR account, return 0
	if(!our_money_account)
		return 0
	if(our_money_account.money < 1000)
		return 0

	return 1

/obj/machinery/computer/betting_terminal/emag_act(var/remaining_charges, var/mob/user)
	if(!rigged)
		user.visible_message("<span class='warning'>\The [user] does something to \the [src], causing the screen to flash!</span>",\
			"<span class='warning'>You activate the [src]'s simulation mode.</span>")
		speak("Simulation mode activated. The next horse selected will come in first place.")
		rigged = 1

	if(rigged)
		to_chat(user, "<span class='warning'>You have already emagged \the [src]!")