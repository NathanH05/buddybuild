import csv
import math
from operator import itemgetter, attrgetter, methodcaller

diet_rows = []
physical_rows = []

# Open the files
with open('diet.csv', 'rb') as csvfile:
	spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
	for row in spamreader:
		diet_rows.append(row)

with open('physical.csv', 'rb') as csvfile:
	spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
	for row in spamreader:
		physical_rows.append(row)

# Remove the titles
diet_rows.pop(0)
physical_rows.pop(0)
physical_rows.sort()
diet_rows.sort()
all_speeds = []

for i in range(0,len(physical_rows)):
	leg_length = float(physical_rows[i][0].split(',')[2]) * 2.5
	calories_per_meal = float(diet_rows[i][0].split(',')[2])
	horse_age = float(diet_rows[i][0].split(',')[1])
	horse_weight = float(physical_rows[i][0].split(',')[1])
	speed = leg_length * math.sqrt(calories_per_meal)/ (horse_age / horse_weight * 200)
	# Adds the speed value to the physical data array
	physical_rows[i].append(speed)

unsorted_horses = []
unsorted_horses_array = []

# Creates a new array with the name of the horse and speed only
for i in physical_rows:
	print i
	for j in i:
		if type(j) == float:
			unsorted_horses.append(j)
		else:
			unsorted_horses.append(j.split(',')[0])

# Place each horse and speed within an array of an outer array
for i in range(0,len(physical_rows)*2):
	if i % 2 == 0:
		unsorted_horses_array.append([unsorted_horses[i],unsorted_horses[i+1]])
# Sport the horse's speeds using the inner element's value
horse_speeds = sorted(unsorted_horses_array, key=itemgetter(1), reverse=True)

print "Top 3 horses are: ..."
print horse_speeds[0][0]
print "Speed =",horse_speeds[0][1]
print horse_speeds[1][0]
print "Speed =",horse_speeds[1][1]
print horse_speeds[2][0]
print "Speed =",horse_speeds[2][1]