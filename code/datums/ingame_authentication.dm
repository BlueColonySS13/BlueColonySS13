// A datum that provides in-game authentication, which other machines can use 
// instead of having to implement that for each individual machine type.

/datum/ingame_authentication
	var/owner_uid = null // UID code of the owner, which is found on their ID card.
	var/staff_pin = 0 // A four digit code that non-owners can use to access on behalf of the owner.

	var/attempts_remaining = 3 // Each wrong try lowers this, at zero the security system is informed, if one exists.

/datum/ingame_authentication/New(new_uid, new_pin)
	owner_uid = new_uid
	staff_pin = new_pin

// Returns TRUE if the user is able to authenticate themselves.
// Holder is the machine or whatever that is being accessed.
/datum/ingame_authentication/proc/attempt_authentication(mob/living/user, atom/movable/holder)
	var/obj/item/weapon/card/id/ID = user.GetIdCard()
	
	// If it's the owner (or someone wearing their ID) they get in automatically.
	if(istype(ID) && owner_uid && owner_uid == ID.unique_ID)
		to_chat(user, span("notice", "Successful authentication by ID."))
		return TRUE
	
	// Otherwise they need to put the right PIN in, if they have the option to do so.
	// Might be better to use strings so you can have PINs like `0451` but that would be inconsistant with other keypads in the game.
	if(staff_pin)
		var/pin_guess = input(user, "Enter the correct PIN. You have [attempts_remaining] attempts remaining. (1111-9999)", "PIN Entry") as null|num
		if(!isnull(pin_guess)) // Hitting cancel provides null.
			if(pin_guess < 1111 || pin_guess > 9999)
				to_chat(user, span("warning", "Invalid PIN."))
				return FALSE
			
			if(pin_guess != staff_pin)
				to_chat(user, span("warning", "Incorrect PIN."))
				attempts_remaining--
				if(attempts_remaining <= 0)
					holder.trigger_lot_security_system(user, /datum/lot_security_option/intrusion, "Failed to enter correct PIN \
					for \the [holder] after [initial(attempts_remaining)] tries.")
					attempts_remaining = initial(attempts_remaining)
					// A lockout system could be implemented here later if someone wants one.
				return FALSE
			
			to_chat(user, span("notice", "Successful authentication by PIN."))
			attempts_remaining = initial(attempts_remaining)
			return TRUE
	return FALSE

// Checks if a new PIN is valid (right now, being four digits from 1111 to 9999).
// Returns the new PIN if it's valid, null otherwise.
/datum/ingame_authentication/proc/validate_pin_change(mob/living/user, new_pin)
	if(!isnull(new_pin))
		if(new_pin > 9999 || new_pin < 1111)
			to_chat(usr, span("warning", "New PIN is invalid. It must contain four digits."))
			return null
		staff_pin = new_pin
		to_chat(usr, span("notice", "New PIN is now <b>[staff_pin]</b>."))
		return new_pin // So the caller can put the number somewhere that will be serialized.