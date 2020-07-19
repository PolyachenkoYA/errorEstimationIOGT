clear; close all;

x1 = 0.2;
x2 = 0.5;
x0 = [0.22, 0.3, 0.35, 0.4, 0.43];
x0 = [0.28, 0.3, 0.35, 0.4, 0.43];
Nx = 1000;
s = 0.1;

Np = length(x0);
x = linspace(x1, x2, Nx);
ymax = g(x0(1), x0(1), s);

fig = getFig('$t$', '$\rho$', ['$\varepsilon = ' num2str(s) '$']);
for i = 1:Np
    plot(fig.ax, x, g(x, x0(i), s), 'Color', getMyColor(i), 'LineWidth', 2);
    plot(fig.ax, [1, 1] * x0(i), [0, ymax], '--', 'Color', getMyColor(i), 'LineWidth', 1.5);
    plot(fig.ax, x0(i), 0, 'o', 'Color', getMyColor(i), 'MarkerSize', 10, 'LineWidth', 2.5);
end
ylim([0, ymax * 1.1]);
legend off;

function p = g(x, x0, s)
    p = exp(-((x - x0) / s).^2 / 2)/(s * sqrt(2*pi));
end

