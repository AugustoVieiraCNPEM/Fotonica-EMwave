% Parâmetros do meio e da onda
L = 100;            % Comprimento do meio (em unidades arbitrárias)
delta_x = 1;        % Passo espacial
num_samples = L/delta_x; % Número de amostras

% Parâmetros da onda
amplitude = 1;      % Amplitude inicial da onda
lambda = 0.00001;
c = 3*10^8;
freq = c / lambda;  % Frequência angular

% Constante de absorção do meio dissipativo
k = 0.1;

% Domínio espacial
x = 0:delta_x:L-delta_x;
y = 0:delta_x:L-delta_x;

% Inicialização da amplitude da onda
A = zeros(num_samples);

% Propagação da onda
for i = 1:num_samples
    for j = 1:num_samples
        % Distância radial do ponto (x, y) ao centro do meio
        r = sqrt((x(i) - L/2)^2 + (y(j) - L/2)^2);
        r_1 = sqrt((x(i) - x(20))^2 + (y(j) - y(20))^2);
        r_5 = sqrt((x(i) - x(80))^2 + (y(j) - y(80))^2);
        r_3 = sqrt((x(i) - x(80))^2 + (y(20) - y(j))^2);
        r_7 = sqrt((x(20) - x(i))^2 + (y(j) - y(80))^2);
        r_dir = abs(r() - sqrt((x(20) - L/2)^2 + (y(20) - L/2)^2));

        % Verifica se a posição está na região dissipativa
        if x(i) < 20 && y(j) < 20  % Região dissipativa 1
            A(i,j) = amplitude * exp(-k*r_1) * cos(r);
        elseif x(i) > 80 && y(j) > 80  % Região dissipativa 5
            A(i,j) = amplitude * exp(-k*r_5) * cos(r);
        elseif x(i) > 80 && y(j) < 20  % Região dissipativa 3
            A(i,j) = amplitude * exp(-k*r_3) * cos(r);
        elseif x(i) < 20 && y(j) > 80  % Região dissipativa 7
            A(i,j) = amplitude * exp(-k*r_7) * cos(r);
        elseif (x(20) <= x(i) && x(i) <= x(80) && y(1) <= y(j) && y(j) <= y(20)) || ...
               (x(80) <= x(i) && x(i) <= x(100) && y(20) <= y(j) && y(j) <= y(80)) || ...
               (x(20) <= x(i) && x(i) <= x(80) && y(80) <= y(j) && y(j) <= y(100)) || ...
               (x(1) <= x(i) && x(i) <= x(20) && y(20) <= y(j) && y(j) <= y(80))
            A(i,j) = amplitude * exp(-k*r) * cos(r);
        else
            % Atualização da amplitude da onda na região ideal
            A(i,j) = amplitude * cos(r);
        end
    end
end

% Plotagem da amplitude da onda em relação à posição no plano XY
surf(x, y, A);
xlabel('Posição Y');
ylabel('Posição X');
zlabel('Amplitude da Onda');
title('Propagação de uma Onda Eletromagnética (Infravermelha) com interface entre Meio Dissipativo e Ideal no Plano XY');

% Sombrear área em x=8
x_shade = [0, 100, 100, 0];
y_shade = [20, 20, 20, 20];
z_shade = [-2, -2, 2, 2];
patch(x_shade, y_shade, z_shade, 'k', 'FaceAlpha', 0.3);
