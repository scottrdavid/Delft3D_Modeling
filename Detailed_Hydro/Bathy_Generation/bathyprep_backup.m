clear all; close all;

%% Data prep for bathy generation, evaporation data, and discharge
%%%%% Set parameters in this section
%%%% Toggles

do_generate_bathy=1;
do_generate_discharge=1;
do_generate_evap=1;



%%%% bathymetric%%%%%%---makes rectangular domain with straight river down middle
                    %%% asummes slope of river and floodplain are the same
                    %%% and channel is rectangular
                    
if do_generate_bathy==1                    
    fplength=8000;      %%% length of floodplain (m)
    fpwidth=2000;       %%% width of floodplain  (m)
    cellsize=15;        %%% cell size  (m)
    fpslope=0.0008;     %%% slope of the floodplain (-)
    upstreamelev=10;    %%% upsream elevation (m)
    rivwidth=150;       %%% river width (m)
    rivdepth=3;       %%% river depth (m)
    rfactor=0.05;       %%% random roughness of +/- that will be added to bathy (m)

    [ fpmat ] = bathygenerator( fplength,fpwidth, cellsize,fpslope,upstreamelev,rivwidth,rivdepth, rfactor);
    
  figure 
  contourf(fpmat,100)
  
end 