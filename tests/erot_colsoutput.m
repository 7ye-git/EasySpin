function ok = test()

% Comparison of two output modes: full matrix vs. rows

a = rand(1,3);
R1 = erot(a);
[x,y,z] = erot(a,'cols');
R2 = [x y z];

ok = areequal(R1,R2);
