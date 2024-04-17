% Define parameters
frequency = 10; % Frequency of the waves
velocity = 5; % Propagation velocity

amplitude_eletro = 1; % Amplitude of electric wave
amplitude_magneto = 1; % Amplitude of magnetic wave


t = linspace(0, 10, 1000); % Time vector
x = linspace(0, 10, 1000); % Space vector along x-axis
y = linspace(-2, 2, 1000); % Space vector along y-axis
z = linspace(-2, 2, 1000); % Space vector along z-axis

% Initialize figure
figure;
hold on;

% Adjust axis labels
xlabel('x');
ylabel('Electric Field');
zlabel('Magnetic Field');
title('Electromagnetic Waves Propagation');

% Set axis limits
xlim([0, 10]);
ylim([-2, 2]);
zlim([-2, 2]);

% Add legend
legend('Electric Wave', 'Magnetic Wave');

% Show grid
grid on;

% Set aspect ratio to be equal
daspect([1 1 1]);

% Initialize plots
eletro_plot = plot3(x, zeros(size(x)), zeros(size(x)), 'b');
magneto_plot = plot3(x, zeros(size(x)), zeros(size(x)), 'r');

% Make axes visible
axis vis3d;

% Shade the 2D patch in the YZ plane at x=8
x_shade = [8, 8, 8, 8];
y_shade = [-2, -2, 2, 2];
z_shade = [-2, 2, 2, -2];
patch(x_shade, y_shade, z_shade, 'k', 'FaceAlpha', 0.3);

% Animation loop
for i = 1:length(t)
    if x(i)<8
        eletro_wave = amplitude_eletro * sin(2 * pi * frequency * t(i) - 2 * pi * frequency * x / velocity);

    % Calculate magnetic wave
        magneto_wave = amplitude_magneto * sin(2 * pi * frequency * t(i) - 2 * pi * frequency * x / velocity);
    else 
        eletro_wave = amplitude_eletro * exp(-3*x)*sen(2*pi*frequency * t(i) - 2 * pi * frequency * x / velocity)
    end
    % Update plots
    set(eletro_plot, 'YData', eletro_wave);
    set(magneto_plot, 'ZData', magneto_wave);

    
    % Pause to control animation speed
    pause(0.01);
    
    % Capture frame for animation
    drawnow;
end

hold off;
