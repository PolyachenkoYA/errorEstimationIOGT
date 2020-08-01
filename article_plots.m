clear;
close all;

N_N = 10;
e_min = 0.02;
e_cut = 0.05;
M0 = 4;
a0 = 0.25; 
b0 = 1.0;
p0 = 0.9;

M_arr = [3, 4, 5];
fig_m = getFig('N', '$\varepsilon$', ['$p_0 = ' num2str(p0 * 100) '\%, Kg = [' num2str(a0) '; ' num2str(b0) ']$']);
N_M = length(M_arr);
for M_i = 1:N_M
    single_proc(fig_m.ax, 0, (b0 - a0) / M_arr(M_i), N_N, p0, e_min, ...
        ['M = ' num2str(M_arr(M_i))], getMyColor(-M_i));
end
e_line(fig_m.ax, e_cut, 'red', N_N);
e_line(fig_m.ax, e_min, getMyColor(5), N_N);
savefig(fig_m.fig, 'fig_M.fig');

p_arr = [0.8, 0.9, 0.97];
fig_p = getFig('N', '$\varepsilon$', ['$M = ' num2str(M0) ', Kg = [' num2str(a0) '; ' num2str(b0) ']$']);
N_p = length(p_arr);
for p_i = 1:N_p
    single_proc(fig_p.ax, 0, (b0 - a0) / M0, N_N, p_arr(p_i), e_min, ...
        ['$p_0 = ' num2str(p_arr(p_i) * 100) '\%$'], getMyColor(-p_i));
end
e_line(fig_p.ax, e_cut, 'red', N_N);
e_line(fig_p.ax, e_min, getMyColor(5), N_N);
savefig(fig_p.fig, 'fig_P.fig');

ab_arr = [[0.5, 1]; [0.25, 1.0]; [0, 1]];
fig_ab = getFig('N', '$\varepsilon$', ['$M = ' num2str(M0) ', p_0 = ' num2str(p0 * 100) '\%$']);
N_ab = length(ab_arr);
for ab_i = 1:N_ab
    a = ab_arr(ab_i, 1);
    b = ab_arr(ab_i, 2);
    single_proc(fig_ab.ax, 0, (b - a) / M0, N_N, p0, e_min, ...
        ['$Kg = [' num2str(a) '; ' num2str(b) ']$'], getMyColor(-ab_i));
end
e_line(fig_ab.ax, e_cut, 'red', N_N);
e_line(fig_ab.ax, e_min, getMyColor(5), N_N);
savefig(fig_ab.fig, 'fig_AB.fig');

function e_line(ax, err, clr, N_N)
    plot(ax, [1, N_N], [1, 1] * err, 'Color', clr, 'LineWidth', 2, 'DisplayName', ['$\varepsilon = ' num2str(err) '$']);
end
