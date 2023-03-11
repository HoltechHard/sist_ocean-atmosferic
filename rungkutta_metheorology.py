#####################################################
#      METHEOROLOGY STUDY - RUNGE-KUTTA METHOD      #
#####################################################

# Description:
# Write a program with numerical method runge kutta for 
# sistem of differential equations
# Goal:
# Study the time evoution of ocean-atmosfere climate system

# import packages
# import math
import numpy as np
import pandas as pd

# function to compute string-math functions
def func(expression, y1, y2, y3, dQ, ca, cm, cd, la, lam, lmd):
    f = eval(expression)
    return f

# numerical method runge-kutta 4-th degree to compute Sist. D.E. 
def rungkutta_metheorology(a, b, y1_ini, y2_ini, y3_ini, n):

    # define the expressions for system of diff. equations    
    # dy1/dt = f1(y1, y2, y3)
    dy1_dt = "(dQ-lam*(y1-y2)-la*y1)/ca"
    # dy2/dt = f2(y1, y2, y3)
    dy2_dt = "(-lam*(y2-y1)-lmd*(y2-y3))/cm"
    # dy3/dt = f3(y1, y2, y3)
    dy3_dt = "(-lmd*(y3-y2))/cd"

    # data structure for string of functions
    f = [dy1_dt, dy2_dt, dy3_dt]
    print("*** System of differential equations ***")
    print("expression 1 ===> dy1/dt = ", f[0])
    print("expression 2 ===> dy2/dt = ", f[1])
    print("expression 3 ===> dy3/dt = ", f[2])

    # definition of constants
    dQ = 1
    ca = 0.45;  cm = 10;    cd = 100
    la = 2.4;   lam = 45;   lmd = 2

    # compute step
    h = (b - a)/n

    # initialize vector of times
    T = np.zeros(shape = (1, n+1))

    # initialize vectors y1, y2, y3
    Y = np.zeros(shape = (3, n+1))

    # split time in time-stemps
    T = np.linspace(start = a, stop = b, num = n+1)
    T = T.reshape((1, n+1))

    # define the initial conditions
    Y[0, 0] = y1_ini
    Y[1, 0] = y2_ini
    Y[2, 0] = y3_ini

    # iterative cycle
    for j in range(0, n):
        # recover variables y1, y2, y3
        y1 = Y[0, j]
        y2 = Y[1, j]
        y3 = Y[2, j]

        # calculate k1, k2, k3, k4 for each variable Y
        # compute k1
        k1 = np.zeros(shape = 3)
        for i in range(0, 3):
            k1[i] = func(f[i], y1, y2, y3, dQ, ca, cm, cd, la, lam, lmd)        

        # compute k2
        k2 = np.zeros(shape = 3)
        ak = np.zeros(shape = 3)

        for i in range(0, 3):
            ak[i] = (h/2) * k1[i]
        
        for i in range(0, 3):
            k2[i] = func(f[i], y1 + ak[0], y2 + ak[1], y3 + ak[2], dQ, ca, cm, cd, la, lam, lmd)
        
        # compute k3
        k3 = np.zeros(shape = 3)
        bk = np.zeros(shape = 3)

        for i in range(0, 3):
            bk[i] = (h/2) * k2[i]
        
        for i in range(0, 3):
            k3[i] = func(f[i], y1 + bk[0], y2 + bk[1], y3 + bk[2], dQ, ca, cm, cd, la, lam, lmd)

        # compute k4
        k4 = np.zeros(shape = 3)
        ck = np.zeros(shape = 3)

        for i in range(0, 3):
            ck[i] = h * k3[i]
        
        for i in range(0, 3):
            k4[i] = func(f[i], y1 + ck[0], y2 + ck[1], y3 + ck[2], dQ, ca, cm, cd, la, lam, lmd)

        # update values for Y
        for i in range(0, 3):
            Y[i, j+1] = Y[i, j] + (h/6) * (k1[i] + 2*k2[i] + 2*k3[i] + k4[i])

    # results
    sol = np.concatenate((T.transpose(), Y.transpose()), axis = 1)
    df = pd.DataFrame(sol, columns = ["time", "y1 = Ta", "y2 = Tm", "y3 = Td"])
    return df

# execution of algorithm and get results
res = rungkutta_metheorology(0, 1, 0, 0, 0, 365)
print(res)

# plot results
import matplotlib.pyplot as plt

ax = plt.gca()
res.plot(kind = "line", x = "time", y = "y1 = Ta", color = "blue", ax = ax)
res.plot(kind = "line", x = "time", y = "y2 = Tm", color = "red", ax = ax)
res.plot(kind = "line", x = "time", y = "y3 = Td", color = "green", ax = ax)
plt.title("Plot temperature vs time")
plt.show()

########### comments for execution ###########

# example of execution function f [specific case]
# func(expression, x, y)

# execution
# sol = rungkutta_metheorology(0, 1, 0, 0, 0, 365)
# 
# configurations for input function
# a = 0
# b = 1
# y1_ini = y2_ini = y3_ini = 0
# n = 365

