winstyle = 'docked';
% winstyle = 'normal';

set(0,'DefaultFigureWindowStyle',winstyle)
set(0,'defaultaxesfontsize',18)
set(0,'defaultaxesfontname','Times New Roman')
% set(0,'defaultfigurecolor',[1 1 1])

% clear VARIABLES;
clear
global spatialFactor;
global c_eps_0 c_mu_0 c_c c_eta_0
global simulationStopTimes;
global AsymForcing
global dels
global SurfHxLeft SurfHyLeft SurfEzLeft SurfHxRight SurfHyRight SurfEzRight



dels = 0.75;
spatialFactor = 1;

c_c = 299792458;                  % speed of light
c_eps_0 = 8.8542149e-12;          % vacuum permittivity
c_mu_0 = 1.2566370614e-6;         % vacuum permeability
c_eta_0 = sqrt(c_mu_0/c_eps_0);

% sets the end time of sim 
tSim = 200e-15
% sets frequency of light
f = 330e12;
% finds wavelength of light
lambda = c_c/f;

% size of box and number of elements in x and y 
xMax{1} = 20e-6;
nx{1} = 200;
ny{1} = 0.75*nx{1};


Reg.n = 1;
% sets up permeability matrix
mu{1} = ones(nx{1},ny{1})*c_mu_0;
% sets up permittivity matrix
epi{1} = ones(nx{1},ny{1})*c_eps_0;
% creates inclution 
epi{1}(125:150,100:110)= c_eps_0*11.3;
epi{1}(125:150,70:80)= c_eps_0*11.3;
epi{1}(125:150,40:50)= c_eps_0*11.3;
epi{1}(90:100,80:100)= c_eps_0*11.3;
epi{1}(90:100,50:70)= c_eps_0*11.3;

sigma{1} = zeros(nx{1},ny{1});
sigmaH{1} = zeros(nx{1},ny{1});
% difines the spatial and time steps 
dx = xMax{1}/nx{1};
dt = 0.25*dx/c_c;
nSteps = round(tSim/dt*2);
yMax = ny{1}*dx;
nsteps_lamda = lambda/dx

%sets up plot
movie = 1;
Plot.off = 0;
Plot.pl = 0;
Plot.ori = '13';
Plot.N = 100;
Plot.MaxEz = 1.1;
Plot.MaxH = Plot.MaxEz/c_eta_0;
Plot.pv = [0 0 90];
Plot.reglim = [0 xMax{1} 0 yMax];

% difiners initial wave
bc{1}.NumS = 1;
% initiates wave start point 
bc{1}.s(1).xpos = nx{1}/(4) + 1;
% type of wave
bc{1}.s(1).type = 'ss';
bc{1}.s(1).fct = @PlaneWaveBC;
% mag = -1/c_eta_0;

mag = 1;
phi = 0;
omega = f*2*pi;
betap = 0;
t0 = 30e-15;
st = -0.05;
s = 0;
y0 = yMax/2;
sty = 1.5*lambda;
bc{1}.s(1).paras = {mag,phi,omega,betap,t0,st,s,y0,sty,'s'};

% difiners initial wave
bc{1}.NumS = 2;
% initiates wave start point 
bc{1}.s(2).xpos = nx{1}/(4) + 20;
% type of wave
bc{1}.s(2).type = 'ss';
bc{1}.s(2).fct = @PlaneWaveBC;
% mag = -1/c_eta_0;

mag = 1;
phi = 0;
omega = f*2*pi;
betap = 0;
t0 = 30e-15;
st = -0.05;
s = 0;
y0 = yMax/4;
sty = 1.5*lambda;
bc{1}.s(2).paras = {mag,phi,omega,betap,t0,st,s,y0,sty,'s'};

% difiners initial wave
bc{1}.NumS = 3;
% initiates wave start point 
bc{1}.s(3).xpos = nx{1}/(4) + 20;
% type of wave
bc{1}.s(3).type = 'ss';
bc{1}.s(3).fct = @PlaneWaveBC;
% mag = -1/c_eta_0;

mag = 1;
phi = 0;
omega = f*2*pi;
betap = 0;
t0 = 30e-15;
st = -0.05;
s = 0;
y0 = 3*yMax/4;
sty = 1.5*lambda;
bc{1}.s(3).paras = {mag,phi,omega,betap,t0,st,s,y0,sty,'s'};


Plot.y0 = round(y0/dx);
% defines boundry behavior 
bc{1}.xm.type = 'a';
bc{1}.xp.type = 'a';
bc{1}.ym.type = 'a';
bc{1}.yp.type = 'a';

pml.width = 20 * spatialFactor;
pml.m = 3.5;

Reg.n  = 1;
Reg.xoff{1} = 0;
Reg.yoff{1} = 0;

RunYeeReg






