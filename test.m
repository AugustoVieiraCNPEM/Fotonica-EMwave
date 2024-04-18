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

for i = 1:length(t)
    % Calcular a amplitude da onda elétrica
    e_wave = amp_e * sin(2*pi*freq*t(i) - 2*pi*freq*x/vel);
    
    %disp (e_wave);
    % Aplicar atenuação após x = 5
    idx = x > 5 & x <= 7;
    e_wave(idx) = e_wave(idx) .* (1 - (x(idx) - 5) / 5);
    
    idx_att = x > 7;
    e_wave(idx_att) = e_wave(idx);

    % Atualizar a plotagem
    set(e_plot, 'YData', e_wave);
    set(m_plot, 'ZData', e_wave); % Para visualização, usamos a mesma amplitude para o campo magnético
    pause(0.01);
    drawnow;

end
hold off;
