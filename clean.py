import pandas as pd
import numpy as np

file_player = pd.read_csv("playerDetail.csv")
file_stats = pd.read_csv("playersStatsSeason.csv")

a = file_player["PlayerID"]
filePlayerStats = file_stats[file_stats['PlayerID'].isin(a)]
# new_f.rename(columns={"Minutes": "MinuteTotal"}, inplace=True)
filePlayerStats.to_csv("playersStatsSeason.csv", index=False)
