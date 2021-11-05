# Had to remove tracking from git
git rm -r --cached 'End-to-End Projects/Red Wine Quality/input/winequality-red.csv'
git commit -m "stop tracking End-to-End Projects/Red Wine Quality/input/winequality-red.csv"

# Add tracking from DVC
dvc add End-to-End\ Projects/Red\ Wine\ Quality/input/winequality-red.csv

#Requires dvc[gdrive]
# Adds remote storage file. I went with google drive because
# it's the freeest solution right now
dvc remote add -d myremote gdrive://$GDRIVE_FOLDER

dvc push


## ok, se apaagar
rm -rf .dvc/cache
rm -f End-to-End\ Projects/Red\ Wine\ Quality/input/winequality-red.csv

# E depois fizer pull
dvc pull
# ele retorna os dados.