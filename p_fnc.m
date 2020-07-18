function p = p_fnc(a, b, x, d)
    p = prod(normcdf((b-x) * (1./d)') - normcdf((a-x) * (1./d)'), 1)';
end