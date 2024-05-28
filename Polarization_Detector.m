%Linear: Ein = [1;1];
%Circular: Ein = [1;1i];
%Elíptica: Ein = [2+1i;1-1i];
%Definir Ein, chamar como "teste(Ein)"

function teste(Ein)
    % Normaliza o vetor do campo elétrico de entrada
    Ein = Ein/norm(Ein);

    % Parâmetros
    fs = 50;              % Frequência de amostragem
    t = 0:1/fs:1;         % Vetor de tempo
    fc = 3e8;             % Frequência da onda
    c = 3e8;              % Velocidade da luz
    lambda = c/fc;        % Comprimento de onda
    k = 2*pi/lambda;      % Número de onda
    omega = 2*pi/0.5;     % Frequência angular (2 rotações por segundo)
    dx = 0.01;            % Passo espacial
    x = 0:dx:2;           % Vetor de posição

    % Cálculo das componentes do campo elétrico e magnético
    npts = numel(x);
    H_y = real(exp(1i*(omega*t(1)-k*x))*Ein(1));  % Campo magnético em y
    E_z = real(exp(1i*(omega*t(1)-k*x))*Ein(2));  % Campo elétrico em z

    % Configura a figura
    figure;
    set(gcf, 'Color', 'white');

    % Subplot para as componentes do campo elétrico e magnético em 3D
    subplot(2, 1, 1);
    hline_y = plot3(x, H_y, zeros(1, npts), 'LineWidth', 2, 'LineStyle', '-', 'Color', 'b');
    hold on;
    hline_z = plot3(x, zeros(1, npts), E_z, 'LineWidth', 2, 'LineStyle', '--', 'Color', 'r');
    hold off;
    xlabel('Posição (m)');
    ylabel('Campo Magnético H_y');
    zlabel('Campo Elétrico E_z');
    legend('H_y', 'E_z');
    title('Componentes do Campo Magnético e Elétrico');
    grid on;
    view(3);

    % Subplot para a trajetória da polarização em 2D ("Detector")
    subplot(2, 1, 2);
    htrace = plot(H_y, E_z, 'b.');
    hold on;
    hdot = plot(H_y(1), E_z(1), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
    hold off;
    xlabel('H_y');
    ylabel('E_z');
    title('Detector (Trajetória de Polarização)');
    grid on;
    axis equal;

    % Atualiza a animação
    for m = 2:numel(t)
        H_y = real(exp(1i*(omega*t(m)-k*x))*Ein(1));  % Campo magnético em y
        E_z = real(exp(1i*(omega*t(m)-k*x))*Ein(2));  % Campo elétrico em z
        set(hline_y, 'YData', H_y);
        set(hline_z, 'ZData', E_z);
        set(htrace, 'XData', H_y, 'YData', E_z);
        set(hdot, 'XData', H_y(1), 'YData', E_z(1));
        drawnow;
        pause(0.1);
    end
end
