% Parâmetros
freq = 10;
vel = 5;
lambda = vel / freq;

amp_e = 1;
amp_m = 1;      % Ajuste valores dos parâmetros de acordo com a necessidade.

t = linspace(0, 10, 1000); % Vetor Tempo
x = linspace(0, 10, 1000); % Vetor espacial ao longo do eixo X
y = linspace(-2, 2, 1000); % Vetor espacial ao longo do eixo Y
z = linspace(-2, 2, 1000); % Vetor espacial ao longo do eixo Z

% Criar matriz para armazenar a amplitude da onda elétrica
e_wave = zeros(size(x));

figure;
hold on;

% Nomes dos eixos
xlabel('x');
ylabel('Electric Field');
zlabel('Magnetic Field');
title('Electromagnetic Waves Propagation');

% Definir fonte de OEM como uma esfera
[X, Y, Z] = sphere;
radius = 0.4;
X1 = radius * X;
Y1 = radius * Y;
Z1 = radius * Z;
surf(X1, Y1, Z1);

% Definir limites dos eixos
xlim([-10, 10]);
ylim([-10, 10]);
zlim([-10, 10]);
grid on;
daspect([1 1 1]);

e_plot = plot3(x, zeros(size(x)), zeros(size(x)), 'b');
m_plot = plot3(x, zeros(size(x)), zeros(size(x)), 'r');
axis vis3d;

% Shade the 2D patch in the YZ plane at x=8
x_shade = [5,5,5,5];
y_shade = [-20, -20, 20, 20];
z_shade = [-20, 20, 20, -20];
patch(x_shade, y_shade, z_shade, 'k', 'FaceAlpha', 0.3);

x_shade = [7,7,7,7];
y_shade = [-20, -20, 20, 20];
z_shade = [-20, 20, 20, -20];
patch(x_shade, y_shade, z_shade, 'k', 'FaceAlpha', 0.3);

for i = 1:length(t)
    % Calcular a amplitude da onda elétrica
    e_wave = amp_e * sin(2*pi*freq*t(i) - 2*pi*freq*x/vel);
    
    % Aplicar atenuação após x = 5
    attenuation_factor = ones(size(x));
    idx = x > 5 & x <= 7;
    attenuation_factor(idx) = 1 - (x(idx) - 5) / 5;
    
    % Estabilizar a amplitude após x = 7
    idx_stabilize = x > 7;
    attenuation_factor(idx_stabilize) = 1 - (7 - 5) / 5; % Use the same attenuation factor as x = 7
    
    e_wave = e_wave .* attenuation_factor;

    % Atualizar a plotagem
    set(e_plot, 'YData', e_wave);
    set(m_plot, 'ZData', e_wave); % Para visualização, usamos a mesma amplitude para o campo magnético
    pause(0.01);
    drawnow;

end
hold off;
