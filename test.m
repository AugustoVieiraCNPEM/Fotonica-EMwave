% Parameters
amplitude = 1;          % Amplitude of the wave
frequency = 10;          % Frequency of the wave
speed = 1;              % Propagation speed of the wave
time = linspace(0, 10, 100); % Time values

% Initialize figure
figure;
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Plot of Sinusoidal Wave Propagating Along X-axis');
grid on;
axis tight;

% Preallocate data arrays
x_data = zeros(size(time));
y_data = zeros(size(time));
z_data = zeros(size(time));

% Animation loop
for idx = 1:length(time)
    t = time(idx);
    % Calculate the x, y, and z coordinates for the wave at the current time
    x_data(idx) = speed * t;               % Propagation along x-axis
    y_data(idx) = amplitude * sin(2 * pi * frequency * t);  % Sinusoidal wave
    z_data(idx) = 0;                       % No variation along z-axis
    
    % Linear attenuation of amplitude after x = 5
    if x_data(idx) > 5
        y_data(idx) = y_data(idx) * exp(-0.5*x_data(idx)); % Linear attenuation
    end
    
    % Plot the wave at the current time
    set(plot3(x_data, y_data, z_data, 'LineWidth', 2), 'XData', x_data(1:idx), 'YData', y_data(1:idx), 'ZData', z_data(1:idx));
    
    % Adjust axis limits if needed
    xlim([0, max(time)]);
    ylim([-amplitude, amplitude]);
    zlim([-amplitude, amplitude]);
    
    % Pause to control the animation speed
    pause(0.1);
end
