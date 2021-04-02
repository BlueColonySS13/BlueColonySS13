from os import listdir
from os.path import isfile, join
onlyfiles = [f for f in listdir(".\\") if isfile(join(".\\", f))]
for file in onlyfiles:
    if file.endswith(".ogg"):
        print("\tnew/datum/track(\"" + file[:-4] + "\", 'sound/music/disco/" + file.replace("'","\\'") + "'),")
input()
