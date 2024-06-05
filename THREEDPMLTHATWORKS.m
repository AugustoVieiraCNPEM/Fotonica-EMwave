% Parâmetros do meio e da onda
L = 100;            % Comprimento do meio (em unidades arbitrárias)
delta_x = 1;        % Passo espacial
num_samples = L / delta_x; % Número de amostras

% Parâmetros da onda
amplitude = 1;      % Amplitude inicial da onda
lambda = 0.00001;
c = 3 * 10^8;
freq = c / lambda;       % Frequência angular

% Constante de absorção do meio dissipativo
k = 0.01;

% Domínio espacial
[x, y] = meshgrid(0:delta_x:L-delta_x, 0:delta_x:L-delta_x);

% Inicialização da amplitude da onda
A = zeros(num_samples);

% Propagação da onda
for i = 1:num_samples
    for j = 1:num_samples
        % Distância radial do ponto (x,y) ao centro do meio
        r = sqrt((x(i, j) - L/2)^2 + (y(i, j) - L/2)^2);
        
        % Verifica se a posição está na região dissipativa
        if x(i, j) < 20 || y(i, j) < 20 || x(i, j) > 80 || y(i, j) > 80
            % Atualização da amplitude da onda na região dissipativa
            A(i, j) = amplitude * exp(-k * r) * cos(r);
        else
            % Atualização da amplitude da onda na região ideal
            A(i, j) = amplitude * cos(r);
        end
    end
end

% Plotagem da amplitude da onda em relação à posição no plano XY
surf(x, y, A);
xlabel('Posição X');
ylabel('Posição Y');
zlabel('Amplitude da Onda');
title('Propagação de uma Onda Eletromagnética com interface entre Meio Dissipativo e Ideal no Plano XY');

% Sombrear área em x=20 ou x=80
x_shade = [20, 20, 80, 80];
y_shade = [0, L, L, 0];
z_shade = [-1, -1, -1, -1]; % Z para fazer sombra
patch(x_shade, y_shade, z_shade, 'k', 'FaceAlpha', 0.3);
