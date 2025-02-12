function dx=KPMC(t,x)
% Parametros
m1=290; 
b1=1000;  
m2=59;
k1=16182; 
f=0; 
k2=19000; 
z1=0.05*sin(0.5*pi*t);
z2= 0.05*sin(20*pi*t);
z=z1;

%----Representación de estados----%

dx=zeros(4,1);

dx(1)=x(3);
dx(2)=x(4);
dx(3)=(1/m1)*(-(b1*x(3))+(b1*x(4))-(k1*x(1))+(k1*x(2))+f);
dx(4)=(1/m2)*((b1*x(3))-(b1*x(4))+(k1*x(1))-((k1+k2)*x(2))+(k2*z)+f);

end


[t,x]=ode45(@KPMC,[0 10], [0 0 0 0]); %[x1 x2 x'1 x'2]

figure(1)
plot(t,x(:,1),'c','LineWidth',3);
grid on
title("Posición de X1");
xlabel("Tiempo");
ylabel("Posición");

figure(2)
plot(t,x(:,2),'m','LineWidth',3);
grid on
title("Posición de  X2");
xlabel("Tiempo");
ylabel("Posición");