function [e0, lines] = main_proc(a, b, x, p0, e_min, Np, prec, ax_p, ax_points, lines)
    %% ================= incorrect input handler ==============
    wrong_ind = find(((x < a*(1 + 5*eps)) + (x > b*(1 - 5*eps))) > 0);
    if(any(wrong_ind))
        disp(['x must be in (' num2str(a) ';' num2str(b) ...
              '), but x(' num2str(wrong_ind(1)) ') = ' num2str(x(wrong_ind(1)))]);
        return;
    end

    %% ===================== data proc ======================
    x = reshape(x, [numel(x), 1]);
    e0 = find_eOpt(a, b, x, p0);
    min_dist = min([abs(x - a); abs(x - b)]);

    %% ====================== data vis ======================
    %Np = 100;
    if(Np > 0)
        e_draw = exp(linspace(log(e_min), log(abs((b-a)/2)), Np)');
        e_draw_im = exp(linspace(log(min(e0, e_min)) - 0.2, log(e_min), Np)');
        p_draw_im = p_fnc(a, b, x, e_draw_im);    
        p_draw = p_fnc(a, b, x, e_draw);

        cla(ax_points)
        hold(ax_points, 'on');
        plot(ax_points, [1, 1] * a, [1, -1], 'Color', 'black', 'LineWidth', 2);
        plot(ax_points, [1, 1] * b, [1, -1], 'Color', 'black', 'LineWidth', 2);
        plot(ax_points, [a, b], [0, 0], 'Color', 'black', 'LineWidth', 2);
        plot(ax_points, x, x*0, 'o', 'MarkerSize', 10, 'LineWidth', 2, 'Color', 'red');
        xlim(ax_points, [a*0.9, b*1.1]);
        legend(ax_points, 'off');

        cla(ax_p);
        pLeg = legend(ax_p);
        set(pLeg, 'FontSize', 16);
        set(pLeg, 'Location', 'best'); 
        set(pLeg, 'Interpreter', 'latex');
        hold(ax_p, 'on');    
        delete(lines('p_e_im'));

        plot(ax_p, e_draw, p_draw, 'DisplayName', '$p(\varepsilon)$',...
                           'Color', getMyColor(1));
        lines('p_e_im') = plot(ax_p, e_draw_im, p_draw_im, '--', 'HandleVisibility', 'off',...
                           'Color', getMyColor(1));
        plot(ax_p, [1, 1] * e_min, [0, 1], 'DisplayName', ['$\varepsilon_{min} = ' num2str(round(e_min, prec)) '$'],...
                                         'LineWidth', 2, 'Color', 'red');
        plot(ax_p, [1, 1] * min_dist, [0, 1], '--', 'DisplayName', ['$d_{min} = ' num2str(round(min_dist, prec)) '$'],...
                                                  'Color', getMyColor(5));
        plot(ax_p, [min([e_draw; e_draw_im]), e0], [1, 1] * p0, '--', 'DisplayName', ['$p_0 = ' num2str(round(p0, prec)) '$'],...
                                                  'Color', 'blue');
        plot(ax_p, [1, 1] * e0, [0, p0], '--', 'DisplayName', ['$\varepsilon_{opt} = ' num2str(round(e0, prec)) '$'],...
                                             'Color', 'blue', 'LineWidth', 2);
        xlim(ax_p, [min([e_draw; e_draw_im]), abs((b-a)/2)]);
    end
        
    %if(e_min > 0)
    %    e0 = max(e0, e_min);
    %end
end

