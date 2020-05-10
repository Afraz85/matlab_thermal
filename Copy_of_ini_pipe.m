clc;clear all;                                                              % Comment 
t=1:1:100;
tin=1;
tf=100;
% delta_t=tf-tin
Tin=[273*ones(10,1); 300*ones(90,1)];
Tin=Tin'
Tb=273;
flowrate=5
area=.01
L=2%m
v=flowrate/(1000*area)
delta_t=L/v
% delta_t=10
%%
RC=140                                                                     
Tout=273*ones(1,100);

for i=(delta_t+1):1:length(Tout)
    
Tout(i)= Tb+(Tin(i-delta_t)-Tb)*exp(-delta_t/RC);
end
figure(1)
plot(t,Tout);shg
hold on;
plot(t,Tin,'r')
%%