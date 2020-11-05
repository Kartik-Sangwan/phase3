import pandas as pd
import numpy as np

file = pd.read_csv("allstar.csv")

all_stars = ["PlayerID",
             "Name",
             "TeamID",
             'Team',
             'Position']

new_f = file[all_stars]
# new_f.rename(columns={"Minutes": "MinuteTotal"}, inplace=True)
new_f.to_csv("allstar.csv", index=False)
