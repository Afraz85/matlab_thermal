clc;clear all;
%% Params initialization


%% new implementation
L=2;                                                                        %% Length of the pipe (m)
Tb=273; % Environmental Temp (K)
rho= 1000                                                                   % kg/m3
cp=4184 %J/K
segments=40
D_pipe = 0.20;                                                              %= sqrt(0.01*4/pi());%  diameter of pipe to get 0.01m² cross section
A =pi*D_pipe^2 / 4
Width_ins = 0.05;                                                           % m Thickness of insulation
K = 0.05;  % W/mK thermal conductivity of insulation material (standard value for pipe insulation)
D_ins_out = D_pipe + 2*Width_ins;
R = log(D_ins_out / D_pipe) / (2 * pi* K * L/segments);
C = (L/segments)*A* rho * cp/1000; % heat capacity per unit length of the water in the pipe
%%
flowrate=5;
 v = flowrate / (A*rho)
dt= L/(v*segments)

t_start=0;
t_end=100;
tt=t_start:dt:t_end;
length_t=length(tt)

param=[rho cp L D_ins_out Tb K  D_pipe flowrate A v  R C ];
% Temp_in=[tt' Tin]
%%
return
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


