#check expressions

import numpy as np
import pandas as pd


# function to compute string-math functions
def func(expression, y1, y2, y3, dQ, ca, cm, cd, la, lam, lmd):
    f = eval(expression)
    return f

# dy1/dt = f1(y1, y2, y3)
dy1_dt = "(dQ-lam*(y1-y2)-la*y1)/ca"
# dy2/dt = f2(y1, y2, y3)
dy2_dt = "(-lam*(y2-y1)-lmd*(y2-y3))/cm"
# dy3/dt = f3(y1, y2, y3)
dy3_dt = "(-lmd*(y3-y2))/cd"

f = [dy1_dt, dy2_dt, dy3_dt]

dQ = 1
ca = 0.45;  cm = 10;    cd = 100
la = 2.4;   lam = 45;   lmd = 2

# inputs
h = 1/365
y1 = 0.005291119900754026
y2 = 3.404233393918332e-05
y3 = 6.338170342623998e-10

k1_1 = func(f[0], y1, y2, y3, dQ, ca, cm, cd, la, lam, lmd)
k1_2 = func(f[1], y1, y2, y3, dQ, ca, cm, cd, la, lam, lmd)
k1_3 = func(f[2], y1, y2, y3, dQ, ca, cm, cd, la, lam, lmd)

k2_1 = func(f[0], y1 + (h/2)*k1_1, y2 + (h/2)*k1_2, y3 + (h/2)*k1_3, dQ, ca, cm, cd, la, lam, lmd)
k2_2 = func(f[1], y1 + (h/2)*k1_1, y2 + (h/2)*k1_2, y3 + (h/2)*k1_3, dQ, ca, cm, cd, la, lam, lmd)
k2_3 = func(f[2], y1 + (h/2)*k1_1, y2 + (h/2)*k1_2, y3 + (h/2)*k1_3, dQ, ca, cm, cd, la, lam, lmd)

k3_1 = func(f[0], y1 + (h/2)*k2_1, y2 + (h/2)*k2_2, y3 + (h/2)*k2_3, dQ, ca, cm, cd, la, lam, lmd)
k3_2 = func(f[1], y1 + (h/2)*k2_1, y2 + (h/2)*k2_2, y3 + (h/2)*k2_3, dQ, ca, cm, cd, la, lam, lmd)
k3_3 = func(f[2], y1 + (h/2)*k2_1, y2 + (h/2)*k2_2, y3 + (h/2)*k2_3, dQ, ca, cm, cd, la, lam, lmd)

k4_1 = func(f[0], y1 + (h)*k3_1, y2 + (h)*k3_2, y3 + (h)*k3_3, dQ, ca, cm, cd, la, lam, lmd)
k4_2 = func(f[1], y1 + (h)*k3_1, y2 + (h)*k3_2, y3 + (h)*k3_3, dQ, ca, cm, cd, la, lam, lmd)
k4_3 = func(f[2], y1 + (h)*k3_1, y2 + (h)*k3_2, y3 + (h)*k3_3, dQ, ca, cm, cd, la, lam, lmd)

y1 = y1 + (h/6)*(k1_1 + 2*k2_1 + 2*k3_1 + k4_1)
y2 = y2 + (h/6)*(k1_2 + 2*k2_2 + 2*k3_2 + k4_2)
y3 = y3 + (h/6)*(k1_3 + 2*k2_3 + 2*k3_3 + k4_3)

# simulation
print(y1)
print(y2)
print(y3)

# initial
# y1 = 0
# y2 = 0
# y3 = 0

# first simulation
# y1 = 0.005291119900754026
# y2 = 3.404233393918332e-05
# y3 = 6.338170342623998e-10

# second simulation 
# y1 = 0.009271388299845532
# y2 = 0.0001240118883061942
# y3 = 4.7429595612685295e-09


