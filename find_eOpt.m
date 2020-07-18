function e0 = find_eOpt(a, b, x, p0)
    e0 = fzero(@(d)(p_fnc(a, b, x, d) - p0), min([abs(x - a); abs(x - b)]));
end