

% 
% run FBA on the ecoli core metabolism (77 reactions)
% 
% reveals the distributions of all unknown fluxes
%

%% initialise

addpath code;

% make sure COBRA is available
initCobraToolbox;

% read model
model = readCbModel('models/Ec_core_flux1','fileType','SBML');

% run baseline FBA
fba = optimizeCbModel(model);

%% FBA sampling

% run with: (200 x 5) samples, 0.01 error on mass-balance
sampler = 'gibbs';
Nsamples = 200;
Nchains = 10;
Nskip = 100;   % Nskip = 1000 for better sample mixing
sdx = 0.01;

% sample, takes 30 seconds
sol = bfba(model, fba);

%% visualise

% plot first 15 flux distributions with fba
figure;
plotfluxes(model, sol, 1:15, fba);

% plot 7x7 flux pair grid
figure;
plotfluxpair(model, sol, [10 2 40 42 45 53 55], fba);

% plot 8 example flux pairs
figure;
plotfluxpair2(model, sol, [30 40; 30 41; 40 47; 15 17; 4 5; 1 6; 10 18; 42 45], fba);

% plot flux covariances
figure;
plotfluxcov(model, sol, 1:50);

% visualise convergences
figure; 
bar(sol.neff);
title('Effective sample sizes');
xlabel('Fluxes');




