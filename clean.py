import pandas as pd
import numpy as np

file = pd.read_csv("playerDetail.csv")

keep_col = ["PlayerID",
            "Name",
            "Status",
            "TeamID",
            "Position",
            "Height",
            "Weight",
            "Salary",
            "Experience",
            "College"]

new_f = file[keep_col]
new_f.to_csv("playerDetail.csv", index=False)