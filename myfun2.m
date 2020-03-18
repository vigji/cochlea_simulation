function term = myfun2(region, state)
f = 0.01;
y = region.y;

term = sin(y*pi/max(y))*f;



