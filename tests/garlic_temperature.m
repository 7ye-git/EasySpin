function ok = test()

% Correct temperature dependence of spectral intensity

T = [100 200 300 400 1000];

Sys.g = [2];
Sys.lwpp = 0.1;
Exp.mwFreq = 9.5;
Exp.Range = [335 341];
for t=1:numel(T)
  Exp.Temperature = T(t);
  y = garlic(Sys,Exp);
  intensity(t) = max(y)*T(t);
end
intensity = intensity/min(intensity);

ok = all(intensity<1+1e-4);
