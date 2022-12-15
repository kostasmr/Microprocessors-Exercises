function s=circuit(a,b,c)
  s =[];
  input_a = a;
  input_b = b;
  input_c = c;
  output_e = sp2AND(input_a, input_b);
  s(end+1)=output_e;
  output_f = spNOT(input_c);
  s(end+1)=output_f;
  output_d = sp2AND(output_e, output_f);
  s(end+1)=output_d;
endfunction

function s=sp2AND(input1sp, input2sp)
  %printf("AND Gate for input probabilities (%f %f):\n",input1sp,input2sp);
  s = input1sp*input2sp;
endfunction

function s=spNOT(input1sp)
  %printf("NOT Gate for input probability (%f ):\n",input1sp);
  s = 1-input1sp;
endfunction

%%%%%%
%gia to circuit3 bazw se sxolia ta print kai ; sta output