clear

a = 1;
n = [10,100,4114,10000];
r = a/2;
x = 0.5;
y = 0.5;
counter = 0;

for i = n
  for j = [0:i] 
    xi = rand(1);
    yi = rand(1);
    root = (xi-x)^2 + (yi-y)^2;
    d = sqrt(root);
    
    if (d<=r)
      counter = counter + 1;
    endif
   endfor
   logos = counter/i;
   p = 4*logos
   counter = 0;
   plot(n,p)
endfor



