function ok = test()

% Test Options.Nuclei

Sys = struct('S',1/2,'g',[2 2 2],'Nucs','19F,1H','A',[1 1 1; 5 6 7]);
Par = struct('mwFreq',9.5,'Field',350);
Par.CrystalOrientation = [0 0 0];
Opt = struct('unused',NaN);

Opt.Nuclei = 1;
p1 = endorfrq(Sys,Par,Opt);
Opt.Nuclei = 2;
p2 = endorfrq(Sys,Par,Opt);
Opt.Nuclei = [];
p3 = endorfrq(Sys,Par,Opt);
Opt.Nuclei = [1 2];
p4 = endorfrq(Sys,Par,Opt);

ok = (numel(p1)==4) && (numel(p2)==4) && (numel(p3)==8) && (numel(p4)==8);
