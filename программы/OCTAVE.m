% format short g

% Параметры
% L = pi; t_final = 1;
% Nx = 200; Nt = 100;
% dx = L / (Nx - 1); dt = t_final / (Nt - 1);
% kappa = 1;

% % Сетка
% x = linspace(0, L, Nx);
% t = linspace(0, t_final, Nt);
% p = zeros(Nx, Nt);

% % Начальное условие
% p(:, 1) = sin(x);

% % Граничные условия
% p(1, :) = 0; p(end, :) = 0;

% % число Куранта
% sigma = kappa * (dt / (dx^2));

% num_internal = Nx - 2;
% alpha = zeros(num_internal, 1);
% beta = zeros(num_internal, 1);

% for j = 1:Nt-1
%     alpha(1) = sigma / (1 + 2 * sigma);
%     beta(1) = p(2, j) / (1 + 2 * sigma);
%     % Прямой ход
%     for k = 2:num_internal
%         denom = (1 + 2 * sigma) - sigma * alpha(k-1);
%         alpha(k) = sigma / denom;
%         beta(k) = (p(k+1, j) + sigma * beta(k-1)) / denom;
%     end

%     % Обратный ход
%     p_back = zeros(num_internal, 1);
%     p_back(end) = beta(end);
%     for k = num_internal-1:-1:1
%         p_back(k) = alpha(k) * p_back(k+1) + beta(k);
%     end
%     p(2:end-1, j+1) = p_back;
% end
% disp(p);