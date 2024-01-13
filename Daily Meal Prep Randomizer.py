"""Daily Meal Prep Randomizer"""

import random
import pandas as pd

#create list of strings with foods for each meal of the day
meals = {"breakfast":["Eggs","Breakfast Muffin", "Yogart", "Oatmeal", "Grits",
                      "French toast", "Fruits", "Cereal", "Chia Seed Smoothie",
                      "Açaí bowl", "Waffles", "Hash browns", "Cream of wheat",
                      "English Muffin Breakfast Sandwich", "Avocado toast"], 
       "lun_din":["Hamberger", "Fried Rice", "Burrito bowl", "Pizza",
                "Sandwich", "Quesadillas", "Burritos", "Salad", "Suchi", "Tacos", 
                "Rice and stew", "Macaroni", "Chilli", "Spegetti"]}

#create list of strings with snack options
snack_options = ["Apple and peanut butter", "Orange", 'Celery',
                 "Peanut butter and jelly", "Crackers",
                 "Cheese and crackers", "Sandwich", "grapes",
                 "Chips and salsa", "Popcorn", "Dark chocolate",
                 "Raisins", "Trail mix", "Granola", "Blueberries"]

def daily_rand_meal_prep(meals_prep: dict, sn=" "):
    '''Takes in a dictionary of all breakfast, lunch,
    and dinner and returns a random value from the list.
    Also takes in an optional argument of snack options.'''
    bf_sample = random.sample(meals_prep["breakfast"], 2)
    print("Breakfast:", bf_sample[0], "and/or", bf_sample[1])
    ld_sample = random.sample(meals_prep["lun_din"], 2)
    print("Lunch:", ld_sample[0], "\nDinner:", ld_sample[1])
    if sn != " ":
        print("Snack: ", random.choice(sn))
        

daily_rand_meal_prep(meals, snack_options)