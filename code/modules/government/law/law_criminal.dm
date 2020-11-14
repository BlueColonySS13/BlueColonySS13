//////// CRIMINAL LAWS //////////

/datum/law/criminal/eluding
	name = "Fleeing & Eluding"
	description = "To non-violently flee from or elude a lawful arrest."

	fine = 500
	cell_time = 6

	notes = "Running, hiding and other nonviolent forms of resisting arrest \
	can be charged with fleeing & eluding. Anything more physical (pushing, \
	disarming resisting cuffs, etc.) should be charged with resisting arrest"



/datum/law/criminal/disorderly
	name = "Disorderly Conduct"
	description = "To act in a way that creates public disturbance or nuisance."

	fine = 800
	cell_time = 5

	notes = "A catch all charge for minor crimes such as littering, \
	yelling obscenities and generally being a dick. Lawful demonstrators \
	can't be charged with this, nor can people speaking about police \
	activities, unless they're exposing sensitive information."


/datum/law/criminal/green
	name = "Procedure Violation (Green)"
	description = "When the code green procedure is not respected."

	fine = 500
	cell_time = 20
	
/datum/law/criminal/property
	name = "Property Damage"
	description = "To damage or destroy public or private property."

	fine = 2500
	cell_time = 20

	notes = "A step up from vandalism, this covers any actual damage done to the \
	property (including synthetics) and maliciously altering its functions."


/datum/law/criminal/dead
	name = "Disrespect to the Dead"
	description = "To abuse or desecrate a corpse. This also includes digging up graves or removing grave markers."

	fine = 2000
	cell_time = 25

/datum/law/criminal/animal
	name = "Animal Cruelty"
	description = "To willingly and knowingly cause unnecessary death or suffering of an animal."

	fine = 1800
	cell_time = 8

	notes = "This charge applies only to unnecessary harm and death. People that kill animals \
	as part of their usual duties (like the chef or the janitor) or those that have sufficient \
	reason to kill (dispatching rodents, space carp, or protecting their life or another's against a hostile animal) should not be charged with this \
	as long as their means of dispatching animals is fairly humane or necessary due to circumstances."

/datum/law/criminal/violation
	name = "Violation of Privacy Laws"
	description = "To invade a person's privacy, share or access personal \
	information protected by privacy laws without a proper reason."
	fine = 4000
	cell_time = 15

	notes = "Your personal records (security, medical and employment), confidential \
	information passed to your doctor or lawyer as well as your identification card, \
	personal items and property are protected by the Polluxian privacy laws. \
	Spreading such information without your approval, neglecting to properly \
	secure it falls under this charge as well as unauthorized searches of \
	your personal property. In addition, so does spying on you through a non-governmental camera console. \
	If a police officer is the offender, refer to Abuse of Police Powers."


/datum/law/criminal/injuction
	name = "Injunction"
	description = " To violate the terms of a legally filed injunction."
	fine = 1500
	cell_time = 15

	notes = "The injunction should be authorized by the judged and handed in \
	a written form to the subject of injunction for it to take legal power."


/datum/law/criminal/theft
	name = "Theft"
	description = "To dishonestly appropriate property of estimated collective value \
	over 400 credits belonging to another person or organisation."
	fine = 2000
	cell_time = 24

	notes = "Note that taking items that are meant for public use all for yourself \
	is also considered theft even if you normally have access to them. For example \
	a doctor bagging all the aid kits from the hospital storage would be committing a crime."

/datum/law/criminal/traffic
	name = "General Traffic Violation"
	description = "To disregard traffic safety guidelines."
	fine = 50
	cell_time = 30

	notes = "Speeding, driving on the opposite side of the road, blowing red lights, \
	parking inappropriately, driving while impaired, jaywalking. If it creates a risk \
	on the road it can be considered a \"General Traffic Violation\"."

/datum/law/criminal/gta
	name = "Grand Theft Auto"
	description = "To steal or otherwise unlawfully acquire a vehicle one does not \
	have the ownership right to."
	fine = 4000
	cell_time = 16

	notes = "Make sure the car wasn't handed to the suspect before you charge them with GTA."


/datum/law/criminal/id
	name = "Failure to Produce Identification"
	description = "To fail to present a valid form of identification upon a lawful request a \
	representative of local or federal authorities."
	fine = 250
	cell_time = 5

	notes = "An officer asking you to produce your identification should provide a \
	reasonable cause for it if requested. Failure to do by the officer is stepping on your \
	privacy and can be considered a \"Violation of Privacy Laws\"."


/datum/law/criminal/force
	name = "Excessive Use of Force"
	description = "To use more than a necessary amount of force in self defense."
	fine = 3000
	cell_time = 20

	notes = "It applies instead of \"Assault\" or \"Assault with a Deadly Weapon\" when a suspect \
	had a reasonable cause to be engaging with another person. Note that severe cases (Ones that \
	end in death or near death) can still be charged with \"Manslaughter\" or even \"Murder\". If a \
	police officer is the offender, refer to Abuse of Police Powers."

/datum/law/criminal/contraband
	name = "Possession of Contraband"
	description = "To be in possession of items controlled or banned by law without proper authorization."
	fine = 1500
	cell_time = 15

	notes = "The exceptions are items that the person is required to be in posession of due to the \
	specifics of their profession (like the drugs inside of chemistry lab) \
	although carrying them out of the workplace is discouraged."

/datum/law/criminal/contraband_d
	name = "Contraband with Intent to Distribute"
	description = "To be in possession of items controlled or banned by law without proper authorization \
	with intent to distribute"
	fine = 2500
	cell_time = 20

	notes = "To be in possession of items controlled or banned by law without proper authorization \
	with intent to distribute A quantity is usually a good tell. A handful of drug pills is a \
	believable amount for personal use. When it's a bag full of pills chances are the person \
	is probably trying to sell them."

/datum/law/criminal/fraud
	name = "Fraud & Embezzlement"
	description = "To use deliberate deception in order to take advantage of other person or organization."
	fine = 4500
	cell_time = 28

	notes = "This includes breaking a written contract and abusing government resources for private gain, \
	such as public employees abandoning their duties by working in private businesses while on-duty."

/datum/law/criminal/justice
	name = "Obstruction of Justice"
	description = "To pervert, impede or obstruct the due administration of justice."
	fine = 2000
	cell_time = 20

	notes = "Lying to law enforcement officers, tampering with evidence, trespassing on crime scenes, \
	loitering near crime scenes when told to leave, interference or failure to cooperate with lawful \
	actions or requests of law enforcement officers are all examples of what could qualify as obstruction of justice."


/datum/law/criminal/reckless
	name = "Reckless Endangerment"
	description = "To act in a way that creates a risk of potential serious physical injury to another \
	person while disregarding the foreseeable consequences of one's actions."
	fine = 1500

/datum/law/criminal/inciting
	name = "Inciting an Unlawful Demonstration"
	fine = 2000
	cell_time = 30

	description = "Inciting, or attempting to incite, an unlawful demonstration."
	notes = "Any civil gathering held on public grounds, excluding the chapel for religious reasons, that counts a total of 6 or more people is considered a demonstration. \
	A demonstration must be approved by City Hall staff or else intervention from the local police department is warranted. \
	Demonstration leaders may be charged with this crime and Disorderly Conduct or Civil Unrest, rowdy protestors with Disorderly Conduct or Civil Unrest."

/datum/law/criminal/trespass
	name = "Trespassing in a Secure Area."
	description = "To unlawfully access a high security area, including police property, government facilities, or high value storage."

	notes= "Entering the armory, mayor's office, government buildings, prison, or the vault, etc. falls under this."
	fine = 3000
	cell_time = 30

/datum/law/criminal/misconduct
	name = "Weapon Handling Misconduct"
	description = "Any citizen of Pollux with a valid weapon permit found to be committing a crime with it or not following proper concealment protocol for said weapon can be charged for this. \
	After three strikes, counting repeat offender price/timer modifiers, the weapon permit shall be hereby null and the weapon confiscated."

	fine = 4000
	cell_time = 30

/datum/law/criminal/impersonating_city
	name = "Impersonating City Officials"
	description = "To impersonate a member of city council, law enforcement, or health personnel."

	fine = 12000
	cell_time = 30

/datum/law/criminal/contempt
	name = "Contempt of Court"
	description = "To be disrespectful towards the Court of law, in the form of \
	behaviour that defies the authority, justice and dignity of the Court."
	
	notes = "Only applies in within court."

	fine = 1000
	cell_time = 20

/datum/law/criminal/hate_speech
	name = "Hate Speech"
	description = "To engage in speech that causes an environment of panic or danger regarding a group of citizens, including calling for violence against them."

	fine = 2000
	notes = "This law only covers discriminatory language that is designed to incite violence towards innate traits that are protected. \
	This covers star system nationality or origin, baseline vatborns, any social background, people who have full prosethetic bodies or \
	robotic limbs, but does not qualify for non-humans, such as synthetics or robots."
	
/datum/law/criminal/tax_evasion
    name = "Tax Evasion"
    description = "To delibrately evade tax where it usually applies through electronic and non-electronic mediums. \
    For manual tax evasion, a form of this is not declaring income or manually paying tax where it is due. \
    This includes avoiding income tax, business tax, all taxes relating to sales or property without an approved government tax break. If it does not \
    apply to taxes, see Fraud and Embezzlement."

    notes = "For a business owner to be charged with this, there needs to be evidence that they were aware this was taking place. Business owners who are \
    aware of this occuring due to technical errors or employee misconduct are required to notify authorities as soon as possible and refund the tax losses \
    to prevent prosecution."
    
    fine = 3000
    cell_time = 25
    
/datum/law/criminal/resisting
	name = "Resisting Arrest"
	description = "To resist a lawful arrest in a non-violent manner."
	cell_time = 30
	fine = 100

	notes = "This usually includes resisting cuffs, \
	this does not qualify if no harm was caused to officers. If this suspect has harmed people, please see \
	Violently Resisting Arrest instead of using this charge."

/datum/law/criminal/insubordination
	name = "Public Insubordination"
	description = "To publicly challenge, defy, interfere with or engage in the derision of the operations, policies or actions of the government while holding a publicly funded position."
	cell_time = 15
	fine = 3000

	notes = "This includes participating in political activities, events or campaigning while being paid by the government, \
	encouraging others to vote a specific way in any vote, and publicly challenging senior government officials without a legal basis. \
 	Anyone charged with this should be demoted."
