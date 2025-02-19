function dx_1 = KPMC(t, x, z)
    % Parámetros
    m1 = 290; 
    b1 = 1000;  
    m2 = 59;
    k1 = 16182; 
    f = 0; 
    k2 = 19000; 

    % ---- Representación de estados ---- %
    dx_1 = zeros(4,1);
    dx_1(1) = x(3);
    dx_1(2) = x(4);
    dx_1(3) = (1/m1) * (-(b1*x(3)) + (b1*x(4)) - (k1*x(1)) + (k1*x(2)) + f);
    dx_1(4) = (1/m2) * ((b1*x(3)) - (b1*x(4)) + (k1*x(1)) - ((k1 + k2) * x(2)) + (k2 * z) + f);
end

% Tiempo de simulación
tspan = [0 10];

% Condiciones iniciales
x0 = [0 0 0 0];

% Definir funciones z1 y z2
z1_func = @(t) 0.05 * sin(0.5 * pi * t);
z2_func = @(t) 0.05 * sin(1 * pi * t);

% Resolver el sistema para z1
[t_z1, x_z1] = ode45(@(t, x) KPMC(t, x, z1_func(t)), tspan, x0);

% Resolver el sistema para z2
[t_z2, x_z2] = ode45(@(t, x) KPMC(t, x, z2_func(t)), tspan, x0);

% Graficar resultados para z1
figure(1)
plot(t_z1, x_z1(:,1), 'b', 'LineWidth', 2); % X1 con z1
hold on
plot(t_z1, x_z1(:,2), 'r', 'LineWidth', 2); % X2 con z1
grid on
title("Respuesta del sistema con z1 = 0.05*sin(0.5*pi*t)");
xlabel("Tiempo");
ylabel("Posición");
legend("X1 con z1", "X2 con z1");
hold off

% Graficar resultados para z2
figure(2)
plot(t_z2, x_z2(:,1), 'g', 'LineWidth', 2); % X1 con z2
hold on
plot(t_z2, x_z2(:,2), 'm', 'LineWidth', 2); % X2 con z2
grid on
title("Respuesta del sistema con z2 = 0.05*sin(2*pi*t)");
xlabel("Tiempo");
ylabel("Posición");
legend("X1 con z2", "X2 con z2");
hold off

% Graficar todos los resultados juntos
figure(3)
plot(t_z1, x_z1(:,1), 'b', 'LineWidth', 2); % X1 con z1
hold on
plot(t_z1, x_z1(:,2), 'r', 'LineWidth', 2); % X2 con z1
plot(t_z2, x_z2(:,1), 'g', 'LineWidth', 2); % X1 con z2
plot(t_z2, x_z2(:,2), 'm', 'LineWidth', 2); % X2 con z2
grid on
title("Comparación de todas las respuestas");
xlabel("Tiempo");
ylabel("Posición");
legend("X1 con z1", "X2 con z1", "X1 con z2", "X2 con z2");
hold off
