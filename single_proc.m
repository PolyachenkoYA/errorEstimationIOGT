function single_proc(ax, a, b, N_N, p0, e_min, legend_title, clr)
    N_arr = 1:N_N;
    e_arr = zeros(N_N, 1);
    for N_i = 1:N_N
        x = linspace(a, b, 2 + N_arr(N_i)); 
        x(end) = []; 
        x(1) = [];

        [e_arr(N_i)] = main_proc(a, b, x, p0, e_min, 0);
    end
    
    plot(ax, N_arr, e_arr, 'DisplayName', legend_title, 'LineWidth', 1, 'Color', clr);
    xlim([1, N_N]);
end
