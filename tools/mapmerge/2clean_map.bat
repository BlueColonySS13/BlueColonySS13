SET z_levels=6
cd 

FOR %%f IN (../../maps/ophelia/*.dmm) DO (
  java -jar MapPatcher.jar -clean ../../maps/ophelia/%%f.backup ../../maps/ophelia/%%f ../../maps/ophelia/%%f
)

pause