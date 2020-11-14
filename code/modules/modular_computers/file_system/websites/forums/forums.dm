/datum/website/forums
	title = "Unnamed Forum"

	var/list/datum/forum_member/members = list()
	var/list/datum/forum/forums = list()
	var/list/banned_members = list()
	var/list/admins = list()

	var/list/audit_log = list()

	var/list/available_categories = list("General", "Admin Only")
	var/list/admin_only_categories = list("Admin Only")

	var/show_edits

	var/forum_description = "This is a generic forum."
	var/open_registration = TRUE				// This forum open to registration?



/datum/forum_member
	var/username = ""
	var/password = ""
	var/email
	var/uid

	var/icon/avatar								//I guess photos can be used? In future, maybe?
	var/banned = FALSE						// Whether the account is banned by the admins.

	var/member_ckey							// So actual admins can keep track of things.

/datum/forum_post
	var/id

	var/title
	var/content
	var/author

	var/post_ckey							// So actual admins can keep track of things.
	var/datum/forum_thread/host_thread
	var/edited

/datum/forum_thread
	var/id

	var/title
	var/list/datum/forum_post/posts = list()
	var/author							// The OP
	var/locked = FALSE						// Admins can lock threads, if this is TRUE, the thread is locked.


/datum/forum
	var/id
	var/list/datum/forum_thread/threads = list()
	var/title = "Unnamed Forum"
	var/desc = "No description provided."
	var/category = "General"
	var/datum/website/forums/host_forum


/datum/website/forums/proc/register_new_member(username, password, email, member_ckey)
	var/datum/forum_member/M = new()
	M.username = username
	M.password = password
	M.email = email
	M.uid = generate_gameid()
	M.member_ckey = member_ckey

	return M


// Forum Audit Log (Persistent log that shows all actions on a forum.
/datum/website/forums/proc/add_audit_log(msg, admin)
	audit_log += "<b>[admin]</b> [msg] - [stationtime2text()]"

// Forum Procs

/datum/website/forums/proc/make_category(category, datum/forum_member/admin)		// returns the full audit log all of moderation actions happening
	if(category in available_categories)
		return 0

	if(admin)
		add_audit_log("made a new category - <b>[category]</b>", admin)

	available_categories += category

	return 1


/datum/website/forums/proc/remove_category(category, datum/forum_member/admin)		// returns the full audit log all of moderation actions happening
	if(admin)
		add_audit_log("removed category <b>\"[category]\"</b>", admin)

	available_categories -= category
	admin_only_categories -= category

	return 1

/datum/website/forums/proc/edit_category(category, new_category, datum/forum_member/admin)		// returns the full audit log all of moderation actions happening
	if(admin)
		add_audit_log("edited category <b>\"[new_category]\"</b>", admin)

	if(category in available_categories)
		available_categories -= category
		available_categories += new_category

	if(category in admin_only_categories)
		admin_only_categories -= category
		admin_only_categories += new_category


//counters
/datum/website/forums/proc/get_audit_log()		// returns the full audit log all of moderation actions happening
	if(!audit_log.len)
		return 0
	return audit_log

/datum/website/forums/proc/member_count()		// returns how many members
	return members.len

/datum/website/forums/proc/admins_count()		// returns how many admins
	return admins.len

/datum/website/forums/proc/thread_count()		// returns how many threads in the entire forum
	return get_threads().len

/datum/website/forums/proc/get_posts()			// returns actual posts
	var/all_posts
	for(var/datum/forum_post/F in get_threads())
		all_posts += F


	return all_posts


/datum/website/forums/proc/get_threads()			// returns actual posts
	var/list/all_threads = list()
	for(var/datum/forum_thread/F in forums)
		all_threads += F

	return all_threads


/datum/website/forums/proc/get_forums_by_cat(category)
	var/list/tally_forums = list()
	for(var/datum/forum/F in forums)
		if(F.category == category)
			tally_forums += F

	return tally_forums



/datum/website/forums/proc/get_cat_thread_count(category)
	var/list/total_threads = get_forums_by_cat(category)
	return total_threads.len


/datum/website/forums/proc/post_count()			// returns how many posts in the entire forum
	var/list/full_posts = get_posts()

	return full_posts.len

// Member related procs

/datum/website/forums/proc/ban_member(datum/forum_member/M, datum/forum_member/admin)
	if(M)
		add_audit_log("banned <b>[M.username]</b> was banned from [title]", admin)

	M.banned = TRUE
	return 1

/datum/website/forums/proc/unban_member(datum/forum_member/M, datum/forum_member/admin)
	if(M)
		add_audit_log("unbanned <b>[M.username]</b> from [title]", admin)
	M.banned = FALSE
	return 1

/datum/website/forums/proc/delete_member(datum/forum_member/M, datum/forum_member/admin)
	if(M)
		add_audit_log("deleted account: <b>[M.username]</b>", admin)
	if(qdel(M))
		return 1

/datum/website/forums/proc/make_admin(datum/forum_member/M, datum/forum_member/admin)
	if(M)
		add_audit_log("made <b>[M.username]</b> an admin", admin)
	admins += M
	return 1

/datum/website/forums/proc/remove_admin(datum/forum_member/M, datum/forum_member/admin)
	if(M)
		add_audit_log("removed <b>[M.username]</b> from admin", admin)
	admins -= M
	return 1

/datum/website/forums/proc/get_post_count(datum/forum_member/M)
	var/postcount
	for(var/datum/forum_post/P in get_posts())
		if(P.author == M)
			postcount++

	return postcount

/*

//Thread related procs

/datum/website/forums/proc/create_thread(datum/forum_member/M, category, thread_title, content)
	var/datum/forum_post/P = new()
	var/datum/forum_thread/T = new()

	// set the thread

	T.title = thread_title
	T.author = M
	T.category = category
	T.host_forum = src

	// set the post

	P.title = thread_title
	P.content = content
	P.author = M
	P.post_ckey = M.member_ckey

	// Add post to the the thread and vice versa.

	T.posts += P
	P.host_thread = T

	if(M)
		add_audit_log("created the thread <b>\"[T.title]\"</b>", admin)


/datum/forum_thread/proc/get_posts()
	return posts

/datum/forum_thread/proc/get_forums()
	return forums

/datum/website/forums/proc/delete_thread(datum/forum_thread/T, datum/forum_member/M)
	if(M)
		add_audit_log("deleted the thread <b>\"[T.title]\"</b>", admin)

	qdel(T.get_posts())
	qdel(T)



/datum/website/forums/proc/move_thread(datum/forum_thread/T, new_category, datum/forum_member/admin)
	if(admin)
		add_audit_log("moved the thread <b>\"[T.title]\"</b> from [T.category] to [new_category]", admin)

	T.category = new_category



/datum/website/forums/proc/lock_thread(datum/forum_thread/T, datum/forum_member/admin)
	if(admin)
		add_audit_log("locked the thread <b>\"[T.title]\"</b> - [stationtime2text()]", admin)

	T.locked = 1


//Post related procs

/datum/forum_thread/proc/new_post(datum/forum_member/M, post_title, content)
	var/datum/forum_post/P = new()

	P.title = post_title
	P.content = content
	P.author = M
	P.post_ckey = M.member_ckey


	// Add post to the the thread and vice versa.

	posts += P
	P.host_thread = src


/datum/forum_thread/proc/delete_post(datum/forum_post/deleted_post, datum/forum_member/M)
	if(M)
		host_forum.add_audit_log("deleted the post <b>\"[deleted_post.title]\"</b>", admin)

	posts -= deleted_post
	qdel(deleted_post)

/datum/forum_thread/proc/edit_post(datum/forum_post/edited_post, new_content, datum/forum_member/M)
	if(M)
		host_forum.add_audit_log("edited the post <b>\"[edited_post.title]\"</b>", admin)

	edited_post.content = new_content
	if(host_forum && host_forum.show_edits)
		edited_post.edited = TRUE


// Registration

/datum/website/forums/proc/register_new_account(mob/user)
	if(!open_registration)
		return 0

	var/username = sanitize(input(usr, "Please enter a username.", "username", null)  as text)
	if(!username)
		return 0

	var/email = sanitize(input(usr, "Please enter an email.", "email", null)  as text)
	if(!email)
		return 0

	var/password = sanitize(input(usr, "Please enter a password.", "password", null)  as text)
	if(!password)
		return 0

*/