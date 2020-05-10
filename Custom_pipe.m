clc;
clear all;
close;

% Constants
cp = 4180;  % J/kgK Heat capacity water
rho = 1000;  % kg/m³ Density water (simplified)

% input parameters
segments = 40;
m_dot = 10; %40/6;
L = 2; %2000;
D_pipe = sqrt(0.01*4/pi());% = 0.30/3;  diameter of pipe to get 0.01m² cross section
Width_ins = 0.05;  % m Thickness of insulation
K = 0.05;  % W/mK thermal conductivity of insulation material (standard value for pipe insulation)
simulation_time = 5;%5000;  % Step size is determined by flow speed

% temperature initialisation
T_init = 80;  % °C
T_env = 0;  % °C
T_in_start = 80;  % °C
T_step = [2, 120];  % After ... sec, increase temperature at inlet to ... °C

% calculating neccesary paramters
nodes = segments + 1;
Area = pi*D_pipe^2/4;
v = m_dot/(rho*Area);
Delay_output = L/v;
delta_t = Delay_output/segments;
time = 0:delta_t:simulation_time;
D_ins_out = D_pipe + 2*Width_ins;
R = log(D_ins_out / D_pipe) / (2 * pi * K * L/segments);
C = L/segments * Area * rho * cp; % heat capacity per unit length of the water in the pipe

% initilising data vectors
T_in = T_in_start*ones(1,length(time));
T_out = T_init*ones(1,length(time));
T_nodes = T_init*ones(1,nodes);
T_update = T_init*ones(1,nodes);

for i = 2:length(time)    
    if time(i) >= T_step(1)
        T_in(i) = T_step(2);
    end
    
    for x = 1:(nodes-1)
        T_update(x+1)= T_env + (T_nodes(x) - T_env) * exp(- delta_t / (R * C));
    end
    T_nodes = T_update;
    T_nodes(1) = T_in(i);
    T_out(i) = T_nodes(nodes);
end

Q_transferred = m_dot*cp*(T_step(2)-T_in_start)/1000; % kW
Q_loss = -m_dot*cp*(T_out(length(T_out))-T_in(length(T_in)))/1000; % kW
disp(['There is a total heat loss of ', num2str(Q_loss), ' KW, meaning a loss of ', num2str(Q_loss/Q_transferred*100), '%.'])

subplot(1,2,1);
plot(time,T_in,'r', time,T_out,'b');
xlabel('Time (s)')
ylabel('Temperature (°C)')
% plot(time,T_in,'r');

subplot(1,2,2); 
plot(linspace(0,L,nodes),T_nodes)
xlabel('Pipe length (m)')
ylabel('Temperature (°C)')

