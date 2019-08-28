function [err,data] = test(opt,olddata)
% Regression test for MD trajectory-based simulation of EPR spectrum using
% cardamom and fast method

rng(1)

% Load pre-processed MD frame trajectory
% -------------------------------------------------------------------------

load('mdfiles/MTSSL_polyAla_traj.mat')

tScale = 2.5;  % diffusion constant of TIP3P model water molecules in MD 
               % simulations is ~2.5x too high, so we scale the time axis

MD = Traj;
MD.dt = MD.dt*tScale;
MD.removeGlobal = 0;
MD.DiffGlobal = 6e6;

% Calculate spectrum using cardamom
% -------------------------------------------------------------------------

T = 250e-9; % length of FID
Par.Dt = 1.0e-9;
Par.nSteps = ceil(T/Par.Dt);

Par.Model = 'MD-direct';
Par.nOrients = 100;

Exp.mwFreq = 9.4;

Sys.Nucs = '14N';
Sys.g = [2.009, 2.006, 2.002];
Sys.A = mt2mhz([6, 36]/10);
Sys.lw = [0.1, 0.1];

Opt.Verbosity = 0;
Opt.Method = 'fast';

[B, spc] = cardamom(Sys,Exp,Par,Opt,MD);
spc = spc/max(spc);

data.spc = spc;

if ~isempty(olddata)
  err = any(abs(olddata.spc-spc)>1e-10);
else
  err = [];
end

if opt.Display
  if ~isempty(olddata)
    plot(B,spc,B,olddata.spc);
    legend('current','previous');
    legend boxoff
    title(mfilename,'Interpreter','none');
    axis tight
  end
end

end