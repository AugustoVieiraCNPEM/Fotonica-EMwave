function PMCPEC(Ein, type)
    % Parâmetros
    fs = 50;             % Frequência de amostragem
    t = 0:1/fs:1;        % Vetor de tempo
    fc = 3e8;            % Frequência da onda
    c = 3e8;             % Velocidade da luz
    lambda = c / fc;     % Comprimento de onda
    k = 2 * pi / lambda; % Número de onda
    omega = 2 * pi * 2;  % Frequência angular (2 rotações por segundo)
    dx = 0.01;           % Passo espacial
    z = 0:dx:2; 
    z_met = 0:dx:1;
    % Vetor de posição (propagação na direção z)

    % Divisão do espaço em duas regiões
    z_reflect = 1;       % Posição do refletor

    % Inicializa as componentes do campo
    H_x = zeros(numel(z), numel(t));
    E_y = zeros(numel(z), numel(t));
    H_x_ref = zeros(numel(z), numel(t));
    E_y_ref = zeros(numel(z), numel(t));

    % Configura a figura
    figure;
    set(gcf, 'Color', 'white');

    % Subplots para as componentes do campo elétrico e magnético
    subplot(3, 1, 1);
    hline_inc_x = plot3(z, zeros(1, numel(z)), zeros(1, numel(z)), 'LineWidth', 2, 'LineStyle', '-', 'Color', 'b');
    hold on;
    hline_inc_y = plot3(z, zeros(1, numel(z)), zeros(1, numel(z)), 'LineWidth', 2, 'LineStyle', '--', 'Color', 'r');
    hold off;
    xlabel('Posição (z)');
    ylabel('Campo Elétrico E_y');
    zlabel('Campo Magnético H_x');
    legend('H_x incidente', 'E_y incidente');
    title('Componentes do Campo Incidente');
    grid on;
    view(3);

    subplot(3, 1, 2);
    hline_ref_x = plot3(z, zeros(1, numel(z)), zeros(1, numel(z)), 'LineWidth', 2, 'LineStyle', '-', 'Color', 'b');
    hold on;
    hline_ref_y = plot3(z, zeros(1, numel(z)), zeros(1, numel(z)), 'LineWidth', 2, 'LineStyle', '--', 'Color', 'r');
    hold off;
    xlabel('Posição (z)');
    ylabel('Campo Elétrico E_y');
    zlabel('Campo Magnético H_x');
    legend('H_x refletido', 'E_y refletido');
    title('Componentes do Campo Refletido');
    grid on;
    view(3);

    subplot(3, 1, 3);
    hline_tot_x = plot3(z, zeros(1, numel(z)), H_x(:, 1), 'LineWidth', 2, 'LineStyle', '-', 'Color', 'b');
    hold on;
    hline_tot_y = plot3(z, E_y(:, 1), zeros(1, numel(z)), 'LineWidth', 2, 'LineStyle', '--', 'Color', 'r');
    hold off;
    xlabel('Posição (z)');
    ylabel('Campo Elétrico E_y');
    zlabel('Campo Magnético H_x');
    legend('H_x total', 'E_y total');
    title('Componentes do Campo Total');
    grid on;
    view(3);

    % Atualiza a animação
    for m = 1:numel(t)
        % Onda incidente
        E_y_inc = real(exp(1i * (omega * t(m) - k * z)) * Ein(2));
        H_x_inc = real(exp(1i * (omega * t(m) - k * z)) * Ein(1));

    % Onda refletida
    if strcmp(type, 'PEC')
    % Onda refletida em PEC
            E_y_ref = real(exp(1i * (omega * t(m) + k * z)) * Ein(2)) *(-1); % Inverte o campo elétrico e direção de propagação
            H_x_ref = real(exp(1i * (omega * t(m) - k * z)) * Ein(1));      % Campo magnético transmitido
    elseif strcmp(type, 'PMC')
    % Onda refletida em PMC
            E_y_ref = real(exp(1i * (omega * t(m) - k * z)) * Ein(2));      % Campo elétrico transmitido
            H_x_ref = real(exp(1i * (omega * t(m) + k * z)) * Ein(1))*(-1); % Inverte o campo magnético
    end

        % Combinação das ondas incidente e refletida
        for i = 1:numel(z)
            if z(i) < z_reflect
                % Antes do refletor
                E_y(i, m) = E_y_inc(i);
                H_x(i, m) = H_x_inc(i);
            else
                % Depois do refletor
                E_y(i, m) = E_y_inc(i) + E_y_ref(i);
                H_x(i, m) = H_x_inc(i) + H_x_ref(i);
            end
        end

        % Atualiza os gráficos
        set(hline_inc_x, 'ZData', H_x_inc);
        set(hline_inc_y, 'YData', E_y_inc);
        set(hline_ref_x, 'ZData', H_x_ref);
        set(hline_ref_y, 'YData', E_y_ref);
        set(hline_tot_x, 'ZData', H_x(:, m));
        set(hline_tot_y, 'YData', E_y(:, m));
        drawnow;
        pause(0.1);
    end
end


