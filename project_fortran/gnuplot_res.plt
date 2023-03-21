set title "Plot temperature vs time"
set autoscale
set xlabel "time (years)"
set ylabel "Temperature (celsius degrees)"

m1 = "./resvar13_lmd1.dat"
m2 = "./resvar13_lmd2.dat"
set grid
plot m1 using 1:2 with lines linecolor "red" lw 3 title "Ta for tmd = 1.0", m1 using 1:3 with lines linecolor "blue" lw 3 title "Tm for tmd = 1.0", m1 using 1:4 with lines linecolor "green" lw 3 title "Td for tmd = 1.0", m2 using 1:2 with lines linecolor "red" lw 1 title "Ta for tmd = 3.6",  m2 using 1:3 with lines linecolor "blue" lw 1 title "Tm for tmd = 3.6", m2 using 1:4 with lines linecolor "green" lw 1 title "Td for tmd = 3.6"
