// A datum that provides in-game authentication, which other machines can use 
// instead of having to implement that for each individual machine type.

/datum/ingame_authentication
	var/owner_uid = null // UID code of the owner, which is found on their ID card.
	var/staff_pin = 0 // A four digit code that non-owners can use to access on behalf of the owner.

/datum/ingame_authentication/New(new_uid, new_pin)
	owner_uid = new_uid
	staff_pin = new_pin

// Returns TRUE if the user is able to authenticate themselves.
/datum/ingame_authentication/proc/attempt_authentication(mob/living/user)
	var/obj/item/weapon/card/id/ID = user.GetIdCard()
	
	// If it's the owner (or someone wearing their ID) they get in automatically.
	if(istype(ID) && owner_uid && owner_uid == ID.unique_ID)
		to_chat(user, span("notice", "Successful authentication by ID."))
		return TRUE
	
	// Otherwise they need to put the right PIN in.
	// Might be better to use strings so you can have PINs like `0451` but that would be inconsistant with other keypads in the game.
	var/pin_guess = input(user, "Enter the correct PIN. (1111-9999)", "PIN Entry") as null|num
	if(!isnull(pin_guess)) // Hitting cancel provides null.
		if(pin_guess < 1111 || pin_guess > 9999)
			to_chat(user, span("warning", "Invalid PIN."))
			return FALSE
		
		if(pin_guess != staff_pin)
			to_chat(user, span("warning", "Incorrect PIN."))
			// Could implement a maximum amount of allowed guesses if someone wanted to here.
			return FALSE
		
		to_chat(user, span("notice", "Successful authentication by PIN."))
		return TRUE
	return FALSE

