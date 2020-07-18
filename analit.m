clear;
close all;

%% ================ init params ===============
a = 0.2;
b = 0.5;
e_min = 0.02;
p0 = normcdf(1);
p0 = 0.95;
% the real value of a property deviates from a measured one less than e0 with
% probability = p0
prec = 3;
Np = 0;

x = [0.35, 0.4, 0.33, 0.45, 0.38]';
x = [0.3, 0.25001, 0.4, 0.45, 0.5, 0.6];
x = [0.375, 0.38, 0.37, 0.365, 0.367, 0.4, 0.45];
x = (a+b)/2;
x = rand(10, 1) * (b*0.95 - a*1.05) + a*1.05;
x = linspace(a, b, 2 + 10); x(end) = []; x(1) = [];
x = [0.28, 0.3, 0.35, 0.4, 0.43];

if(Np > 0)
    lines = containers.Map({'p_e_im'}, {[]});

    fig_prob = getFig('$\varepsilon$', 'p',...
                      ['$p(\varepsilon) | p_0 = ' num2str(round(p0, prec)) '$'],...
                      'log');
    fig_points = getFig('x', 'y');

    main_proc(a, b, x, p0, e_min, Np, prec, fig_prob.ax, fig_points.ax, lines);
else
    N_arr = 1:15;
    N_N = length(N_arr);
    e_arr = zeros(N_N, 1);
    for N_i = 1:N_N
        x = linspace(a, b, 2 + N_arr(N_i)); x(end) = []; x(1) = [];

        [e_arr(N_i)] = main_proc(a, b, x, p0, e_min, 0);
    end

    getFig('N', '$\varepsilon$', ['[' num2str(a) ';' num2str(b) '] \hspace{3pt} $p_0 = ' num2str(p0) '$']);
    plot(N_arr, e_arr, 'DisplayName', 'data', 'LineWidth', 2);

    R = corrcoef(1 ./ N_arr, e_arr);
    lin_fit = polyfit(1 ./ N_arr, e_arr, 1);
    getFig('1/N', '$\varepsilon$', ['$p_0 = ' num2str(p0) '; R = ' num2str(R(1,2)) '$']);
    plot(1 ./ N_arr, e_arr, 'x', 'DisplayName', 'data');
    plot(1 ./ N_arr, (1 ./ N_arr) * lin_fit(1) + lin_fit(2), '-', 'DisplayName', 'line fit')

    R_log = corrcoef(log(N_arr), log(e_arr));
    log_fit = polyfit(log(N_arr), log(e_arr), 1);
    getFig('N', '$\varepsilon$', ['$p_0 = ' num2str(p0) '; R = ' num2str(R(1,2)) '$'], 'log', 'log');
    plot(N_arr, e_arr, 'x', 'DisplayName', 'data', 'LineWidth', 1.5);
    plot(N_arr, exp(log_fit(1)*log(N_arr) + log_fit(2)), '-', 'DisplayName', 'line fit', 'LineWidth', 1.5);
end
