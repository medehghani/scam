clear all
fname="BJT_1.cir";
transistor_netlist
fname="output.test";
scam

H=v_2/v_1


H=collect(H)
pretty(H)

Hnumbers = eval(H)

[n,d]=numden(Hnumbers)
mySys=tf(sym2poly(n),sym2poly(d))

mySys=minreal(mySys)
% step(mySys)
bode(mySys)
% https://lpsa.swarthmore.edu/Systems/Electrical/mna/MNA6.html
% https://www.mathworks.com/help/control/ref/tf.html