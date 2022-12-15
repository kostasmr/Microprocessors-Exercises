function s=circuit2(a,b,c)
  l=[];
  l = circuit(a,b,c);
  Esw_e = 2*l(1)*(1-l(1))
  Esw_f = 2*l(2)*(1-l(2))
  Esw_d = 2*l(3)*(1-l(3))
endfunction

