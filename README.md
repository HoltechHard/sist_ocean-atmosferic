# Climate System ocean-atmospheric
Time evolution of oceanic-atmospheric temperature using  
numeric method of Runge-Kutta in 4-th order

Tasks
======

(1) Write a program for numeric solution of system of differential equations (1) - (4)  
  
(2) When configure different values for timestamp, calculate time evolutin of climate  
ocean-atmospheric system until solution achieve stationary state.  
The criterion to stablish stationary state is the condition for convergence of some  
default precision for before and after values for Td.  
Climate system will take this parameters:  
dQ = 1 BT/m^2
ca = 0.45 BT/m^2 * year^-1 * K  
cm = 10 BT/m^2 * year^-1 * K  
cd = 100 BT/m^2 * year^-1 * K  
la = 2.4 BT/m^2 * K  
lam = 45 BT/m^2 * K  
lmd = 2 BT/m^2 * K  

(3) Compare the results of analytical solutions and numeric approximate solutions  
(in equations 7-18-20) and estimate optimal timestamp  

(4) Given optimal timestamp, get a numerical solution to system (1) - (4) in this  
next 2 different cases:  

  4.a) don't exist interaction between ocean and atmosphere  
  (lam = 0, Tm = 0, Td = 0)

  4.b) don't exist interaction between BKC and GC
  (lmd = 0, Td = 0)  

(5) Research sensibility for system (1) - (4) solution for variations of coefficient  lmd,  
for which solution is given for lmd = 1 and lmd = 4 BT/m^2 * k

(6) Use the dataset to analyze the characteristics of time evolution of individual factors of  
climate system and for climate system on the whole.  
