clc; clear; close all;
L = 1.0; t_final = 1.0; kappa = 1.0;
Nx = 50; dx = L / (Nx - 1); x = linspace(0, L, Nx);
dt = 0.4 * (dx^2 / kappa); Nt = round(t_final / dt);
p = zeros(1, Nx); p(1) = 1; p(end) = 0;

fid = fopen('plot_data.tex', 'w');
fprintf(fid, '\\begin{tikzpicture}[x=7cm, y=5cm, >=Stealth, thick]\n');
fprintf(fid, '\\draw[step=0.2, gray!20, very thin] (0,0) grid (1,1);\n');

fprintf(fid, '\\foreach \\x in {0.2, 0.4, 0.6, 0.8, 1} {\n');
fprintf(fid, '  \\draw (\\x, 2pt) -- (\\x, -2pt) node[below] {\\x};\n');
fprintf(fid, '}\n');

fprintf(fid, '\\foreach \\y in {0.2, 0.4, 0.6, 0.8, 1} {\n');
fprintf(fid, '  \\draw (2pt, \\y) -- (-2pt, \\y) node[left] {\\y};\n');
fprintf(fid, '}\n');

fprintf(fid, '\\node[below left] at (0,0) {0};\n');

fprintf(fid, '\\draw[->, thick] (0,0) -- (1.15,0) node[below right] {\\(x\\)};\n');
fprintf(fid, '\\draw[->, thick] (0,0) -- (0,1.15) node[left] {\\(p\\)};\n');

steady_state = false; n = 0; p_prev = p;

while ~steady_state
    n = n + 1;
    p_inner = p(2:end-1) + (kappa * dt / dx^2) * (p(3:end) - 2*p(2:end-1) + p(1:end-2));
    p = [1, p_inner, 0];

    if mod(n, max(1,floor(Nt/50))) == 0
        fprintf(fid, '\\draw[blue, opacity=0.4] plot coordinates {');
        for i = 1:Nx
            fprintf(fid, '(%.3f,%.3f)', x(i), p(i));
        end
        fprintf(fid, '};\n');
    end

    if max(abs(p - p_prev)) < 1e-6
        steady_state = true;
    end
    p_prev = p;
end

fprintf(fid, '\\draw[very thick, red] (0,1) -- (1,0);\n');
fprintf(fid, '\\end{tikzpicture}\n');
fclose(fid);

disp('Файл plot_data.tex успешно создан!');
