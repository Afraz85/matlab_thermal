clc;clear all;
%% Params initialization
rho= 1000 % kg/m3
Cp_w=4.184 %J/K
L=2;     %% Length of the pipe (m)
D_ins_out=2 %% # m Outer diameter of insulation
Tb=273; % Environmental Temp (K)
K = .1; %thermal conductivity of insulation material[W/mK]
D_steel_out=1;
D_steel_in =.01;
flowrate=5
A =0.0100% pi * D_steel_in*2 / 4 
v = .5%flowrate / (A*rho)
delta_t=1%
R_tot = log(D_ins_out / D_steel_out) / (2 * pi * K)  %%  Total heat loss K/(W/m)
RC=140% R_tot * A * rho * Cp_w % 1/s RC-component related to thermal inertia (time constant)

t_start=0;
t_end=100;
tt=t_start:delta_t:t_end;
length_t=length(tt)
%%
delay=4 ; %L/v
Tramp_time=10 % sec;
Tin=[273.15*ones(Tramp_time,1); 300*ones(length_t-Tramp_time,1)]
% plot(tt,Tin)
param=[rho Cp_w L D_ins_out Tb K D_steel_out D_steel_in flowrate A v delay R_tot RC length_t Tramp_time];
Temp_in=[tt' Tin]
%%
% return
  sim('PipeModel',t_end);
%  return
%% Params to be used in discretization code
%  nr_nodes  %  The number of nodes in the discretisation of the pipe (accuracy)
%  dx = length / (nr_nodes-1)  % m Distance between 2 nodes (so for 1 discretised pipe section)
%  nodes = np.linspace(0,length,nr_nodes)  % np array with coordinates of the nodes
%  Tw = np.array([Pipe.Tw_initial]*nr_nodes)  % K Temperature of the water at each node (using numpy array)
%  dt = dx / v  % s Time step = time needed for water to reach next nod
    

%% Plotting Temp_in and Temp_out 


figure(2);
axes('fontsize',19)  %35
plot(t,Temp_in(:,2),'Color','r','Linewidth',0.7);
grid on,hold on
plot(t,Temp_out,'Color','b','Linewidth',0.7);
set(gca,'Xlim',[0 t(end)])
% set(gca,'Ylim',[299 325])
set(gca,'XGrid','on', 'YGrid','on','GridLineStyle','-');
set(gca,'XMinorGrid','on', 'YMinorGrid','off','MinorGridLineStyle','-.');

h1=legend('$Temp_{in}$','$Temp_{out}$','Location','northeast','Orientation','Horizontal');

xlabel('$t$ in $\mathrm{sec}$','fontsize',19,'interpreter','latex')
ylabel('${Temp}$ in $K$','fontsize',19,'interpreter','latex')
set(h1,'fontsize',16,'interpreter','latex')


