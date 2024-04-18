%Parametros
amplitude_E = 10;
amplitude_M = 10;
velocidade = 10;
lambda = 2;
frequencia = velocidade/lambda;

t = linspace(0, 10, 1000); % Time vector
x = linspace(0, 10, 1000); % Space vector along x-axis
y = linspace(-2, 2, 1000); % Space vector along y-axis
z = linspace(-2, 2, 1000); % Space vector along z-axis
x_zero=zeros(size(x));
y_zero=zeros(size(y));
z_zero=zeros(size(y));



% Initialize figure
figure;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Plot of Sinusoidal Wave Propagating Along X-axis');
grid on;
axis vis3d;

for idx=1:length(t)
    time = t(idx);
    %calculando os valores de x, y e z no momneto t(idx)
    x(idx) = time*velocidade;
    y(idx) = amplitude_M*sin(2* pi * frequencia * time);
    z(idx) = amplitude_E*sin(2* pi * frequencia * time);
    
    %Onda Não Polarizada
    set(plot3(x, y, z_zero ,'LineWidth', 2, x, z, y_zero, 'LineWidth', 2), 'XData', x(1:idx), 'YData', y(1:idx), 'ZData', z_zero(1:idx));
    %set(plot3(x, z, y_zero, 'LineWidth', 2), 'XData', x(1:idx), 'YData', y_zero(1:idx), 'ZData', z(1:idx));
    
    %Onda Linearmente Polarizada
    %set(plot3(x, y, z, 'LineWidth', 2), 'XData', x(1:idx), 'YData', y(1:idx), 'ZData', z(1:idx));
    
    
    
    
    
    pause(0.1);
end
