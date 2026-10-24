clc; clear; close all;
L = 1.0; t_final = 1.0; kappa = 1.0;

Nx = 50;
dx = L / (Nx - 1);
x = linspace(0, L, Nx);

dt = 0.4 * (dx^2 / kappa);
Nt = round(t_final / dt);

p = zeros(1, Nx);
p(1) = 1;
p(end) = 0;

figure('Color', 'w'); hold on; grid on; box on;
xlim([0 L]); ylim([-0.05 1.05]);
k = 1;
steady_state = false;
n = 0;
p_prev = p;

while ~steady_state
    n = n + 1;

    p_inner = p(2:end-1) + (kappa * dt / dx^2) * (p(3:end) - 2*p(2:end-1) + p(1:end-2));

    p = [1, p_inner, 0];

    if mod(n, max(1,floor(Nt/50))) == 0
        plot(x, p, 'b', 'LineWidth', 1.2);
        k = k + 1;
        drawnow;
    end

    if max(abs(p - p_prev)) < 1e-6
        steady_state = true;
    end
    p_prev = p;
end

plot(x, p, 'r-', 'LineWidth', 2.5);
xlabel('X');
ylabel('P');
hold off;
