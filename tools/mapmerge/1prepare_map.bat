cd ../../maps/ophelia

FOR %%f IN (*.dmm) DO (
  copy %%f %%f.backup
)

pause
