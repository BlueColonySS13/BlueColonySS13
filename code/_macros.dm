#define Clamp(x, y, z) 	(x <= y ? y : (x >= z ? z : x))

#define span(class, text) ("<span class='[class]'>[text]</span>")

#define get_turf(A) get_step(A,0)

#define get_x(A) (get_step(A, 0)?.x || 0)

#define get_y(A) (get_step(A, 0)?.y || 0)

#define get_z(A) (get_step(A, 0)?.z || 0)

#define isAI(A) istype(A, /mob/living/silicon/ai)

#define isalien(A) istype(A, /mob/living/carbon/alien)

#define isanimal(A) istype(A, /mob/living/simple_animal)

#define isbrain(A) istype(A, /mob/living/carbon/brain)

#define iscarbon(A) istype(A, /mob/living/carbon)

#define iscorgi(A) istype(A, /mob/living/simple_animal/corgi)

#define isEye(A) istype(A, /mob/observer/eye)

#define ishuman(A) istype(A, /mob/living/carbon/human)

#define isliving(A) istype(A, /mob/living)

#define ismouse(A) istype(A, /mob/living/simple_animal/mouse)

#define isnewplayer(A) istype(A, /mob/new_player)

#define isobserver(A) istype(A, /mob/observer/dead)

#define ispAI(A) istype(A, /mob/living/silicon/pai)

#define isrobot(A) istype(A, /mob/living/silicon/robot)

#define issilicon(A) istype(A, /mob/living/silicon)

#define isvoice(A) istype(A, /mob/living/voice)

#define isslime(A) istype(A, /mob/living/simple_animal/slime)

#define isbot(A) istype(A, /mob/living/bot)

#define isxeno(A) istype(A, /mob/living/simple_animal/xeno)

#define sequential_id(key) uniqueness_repository.Generate(/datum/uniqueness_generator/id_sequential, key)

#define random_id(key,min_id,max_id) uniqueness_repository.Generate(/datum/uniqueness_generator/id_random, key, min_id, max_id)

#define MAP_IMAGE_PATH "nano/images/[using_map.path]/"

#define map_image_file_name(z_level) "[using_map.path]-[z_level].png"

#define RANDOM_BLOOD_TYPE pick(4;"O-", 36;"O+", 3;"A-", 28;"A+", 1;"B-", 20;"B+", 1;"AB-", 5;"AB+")

#define isclient(A) istype(A, /client)

#define to_chat(target, message) target << message
#define to_world(message) world << message
#define to_world_log(message) world.log << message
// TODO - Baystation has this log to crazy places. For now lets just world.log, but maybe look into it later.
#define log_world(message) world.log << message
#define to_file(file_entry, source_var) file_entry << source_var
#define from_file(file_entry, target_var) file_entry >> target_var

// From TG, might be useful to have.
// Didn't port SEND_TEXT() since to_chat() appears to serve the same purpose.
#define DIRECT_OUTPUT(A, B) A << B
#define SEND_IMAGE(target, image) DIRECT_OUTPUT(target, image)
#define SEND_SOUND(target, sound) DIRECT_OUTPUT(target, sound)

#define CanInteract(user, state) (CanUseTopic(user, state) == STATUS_INTERACTIVE)

#define QDEL_NULL_LIST(x) if(x) { for(var/y in x) { qdel(y) } ; x = null }

#define QDEL_NULL(x) if(x) { qdel(x) ; x = null }

#define ARGS_DEBUG log_debug("[__FILE__] - [__LINE__]") ; for(var/arg in args) { log_debug("\t[log_info_line(arg)]") }

#define sound_to(target, sound)                             target << sound
#define show_browser(target, browser_content, browser_name) target << browse(browser_content, browser_name)
#define show_image(target, image)                           target << image
#define send_rsc(target, rsc_content, rsc_name)             target << browse_rsc(rsc_content, rsc_name)

#define any2ref(x) "\ref[x]"

//Currently used in SDQL2 stuff
#define send_output(target, msg, control) target << output(msg, control)
#define send_link(target, url) target << link(url)

#define SPAN_NOTICE(X) "<span class='notice'>[X]</span>"

#define SPAN_WARNING(X) "<span class='warning'>[X]</span>"

#define SPAN_DANGER(X) "<span class='danger'>[X]</span>"

#define SPAN_OCCULT(X) "<span class='cult'>[X]</span>"

#define FONT_SMALL(X) "<font size='1'>[X]</font>"

#define FONT_NORMAL(X) "<font size='2'>[X]</font>"

#define FONT_LARGE(X) "<font size='3'>[X]</font>"

#define FONT_HUGE(X) "<font size='4'>[X]</font>"

#define FONT_GIANT(X) "<font size='5'>[X]</font>"