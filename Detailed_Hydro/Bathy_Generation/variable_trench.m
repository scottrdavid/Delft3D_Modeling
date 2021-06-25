clear all; close all;

%% Data prep for bathy generation, evaporation data, and discharge
%%%%% Set parameters in this section
%%%% Toggles

do_generate_bathy=1;
do_generate_oxbow=0;
do_generate_trench=1;
do_couple_bathy_ox=1;
do_show_plots=1;
do_generate_output=0;
do_output_xyz_for_delft3D=1; 
outputneg=1;


%%%%VARIABLES%%%%
%%%Floodplain/River
    fplength=3510;      %%% length of floodplain (m)
    fpwidth=1005;       %%% width of floodplain  (m)
    cellsize=15;        %%% cell size  (m)
    fpslope=0.00004;      %%% slope of the floodplain (-)
    upstreamelev=10;    %%% upsream elevation (m)
    rivwidth=0;         %%% river width (m)
    rivdepth=0;         %%% river depth (m)
    rfactor=0.001;       %%% random roughness of +/- that will be added to bathy (m)
%%%Oxbow
    oxwidth=300;
    oxlength=2000;
    oxchanwidth=80;
    oxdepth=1;
    orientation=2; %1 opening north 2 east 3 south 4 west
    dist=500; %%% distance from downstream boundary for oxbow placement
    
%%%Trench
tdepth=2;
twidth=90;
dist=500;

%%% Outputfiles
modelorigin=100;%%% delft hates starting at 0,0 so using 100,100 in my runs
xyzfilename=['r001_d3_5kby1005_S00004trench1x90mbathy.xyz'];



%% Computation


%%%% bathymetric%%%%%%---makes rectangular domain with straight river down middle
                    %%% asummes slope of river and floodplain are the same
                    %%% and channel is rectangular
                    
if do_generate_bathy==1                    
%     fplength=3495;      %%% length of floodplain (m)
%     fpwidth=1005;       %%% width of floodplain  (m)
%     cellsize=15;        %%% cell size  (m)
%     fpslope=0.0008;     %%% slope of the floodplain (-)
%     upstreamelev=10;    %%% upsream elevation (m)
%     rivwidth=0;       %%% river width (m)
%     rivdepth=0;         %%% river depth (m)
%     rfactor=0.01;       %%% random roughness of +/- that will be added to bathy (m)

    [ fpmat ] = bathygenerator( fplength,fpwidth, cellsize,fpslope,upstreamelev,rivwidth,rivdepth, rfactor);
end

if do_generate_oxbow==1
%     oxwidth=400;
%     oxlength=300;
%     oxchanwidth=80;
%     oxdepth=1;
%     orientation=3; %1 opening north 2 east 3 south 4 west
%     
    oxbow=generate_oxbow(oxdepth, oxwidth, oxlength, oxchanwidth, cellsize,orientation);
    
  if do_couple_bathy_ox==1
%    dist=500 ;
   bathy_with_feature=bathy_coupler(fpmat,oxbow,dist,cellsize);
  end
  
    
end


if do_generate_trench==1;

    trench=generate_trench(tdepth, twidth, fpwidth, cellsize);
    bathy_with_feature=trench_coupler(fpmat,trench,dist,cellsize);

end

if do_show_plots==1
    figure 
    subplot(1,2,1)
    contourf(fpmat,100)
    subplot(1,2,2) 
    if do_generate_oxbow==1
    contourf(oxbow,50)
    elseif do_generate_trench==1;
        contourf(trench,50)
    end
    figure
    contourf(bathy_with_feature,100)
end
  

if do_output_xyz_for_delft3D==1
    xyzdata=xyzmaker(bathy_with_feature,modelorigin); 
    if outputneg==1
       xyzdata(:,3)= xyzdata(:,3)*-1;
    end
    save(xyzfilename,'xyzdata','-ascii')
end







    