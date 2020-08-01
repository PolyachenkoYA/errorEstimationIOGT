clear;
close all;

%% =================== params ===================
bnds = [0, 0.3, 0.5, 0.7, 1];
samples = [0.1, 0.15, 0.12, 0.2 ,...
           0.35, 0.4, 0.33, 0.45,...
           0.52, 0.54, 0.6, 0.51,...
           0.7, 0.72, 0.75      ]';
i_reg = 2;
N = 100000;

%% ================== simulation ================
Nd = 100;
Ns = 1;
d_arr = 10.^linspace(-2.5, log(0.5)/log(10), Nd)';
p_arr = zeros(Nd, 1);
%loc_samples = samples(((samples > bnds(i_reg)).*(samples < bnds(i_reg + 1))) > 0)';
loc_samples = rand(Ns, 1) * (bnds(i_reg + 1)*0.95 - bnds(i_reg)*1.05) + bnds(i_reg)*1.05;

d_min = min([abs(loc_samples - bnds(i_reg)); abs(loc_samples - bnds(i_reg + 1))]);
fig_dat = getFig('x', 'y', ['$d_{min} = ' num2str(d_min) '$']);
plot(fig_dat.ax, loc_samples, loc_samples * 0, 'x', 'DisplayName', 'data');
plot(fig_dat.ax, [1, 1] * bnds(i_reg), [1, -1], 'DisplayName', 'interval bounds',...
                                            'Color', getMyColor(1), 'LineWidth', 2);
plot(fig_dat.ax, [1, 1] * bnds(i_reg + 1), [1, -1],...
     'Color', getMyColor(1), 'HandleVisibility', 'off', 'LineWidth', 2);
xlim([bnds(i_reg) * 0.9, bnds(i_reg + 1) * 1.1]);

for i_d = 1:Nd
    p_arr(i_d) = get_percent(loc_samples, d_arr(i_d), N, [bnds(i_reg), bnds(i_reg + 1)]);
    disp(i_d / Nd);
end

b0 = fminsearch(@(b)(sum((p_arr - normcdf(log(d_arr)/log(10), b(1), b(2))).^2)), [d_min; 0.5]);

%% ==================== visual ===================
fig = getFig('$\varepsilon$', 'p', '', 'log');
plot(fig.ax, d_arr, p_arr, 'x', 'DisplayName', 'stats');
dp = abs((p_arr(2:end) - p_arr(1:(end - 1))) ./ (d_arr(2:end) - d_arr(1:(end - 1))));
%plot(ax, (d_arr(2:end) + d_arr(1:(end - 1))) / 2, ...
%         dp / max(dp), ...
%         'DisplayName', 'dp');
plot(fig.ax, [1, 1] * d_min, [1, 0.001], 'DisplayName', '$d_{min}$');
plot(fig.ax, d_arr, normcdf(log(d_arr)/log(10), b0(1), b0(2)), 'DisplayName', 'erf fit');
plot(fig.ax, [1, 1] * 10^b0(1), [1, 0.001], 'DisplayName', '$d_{th}$');

function p = get_percent(loc_samples, d, N, bnds)
    reals = normrnd(loc_samples * ones(1, N), d);
    p = mean((any(reals < bnds(1), 1) + any(reals > bnds(2), 1)) > 0);
end
