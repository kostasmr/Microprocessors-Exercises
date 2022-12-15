
function s=circuit(input1,input2,input3)
  global SignalsTable1={0,0,0,0,0,0};
  E1.type="AND"; E1.inputs=[1,2]; E1.output=5;
  E2.type="NOT"; E2.inputs=[3]; E2.output=6;
  E3.type="AND"; E3.inputs=[5,6]; E3.output=4;
  ElementsTable={E1,E2,E3};
  SignalsTable1{1}=input1;
  SignalsTable1{2}=input2;
  SignalsTable1{3}=input3;
  for i=1:size(ElementsTable,2)
    process(ElementsTable{i});
    printf("Switching activity for Element%d is : ",i);
    esw(SignalsTable1{ElementsTable{i}.output});
  endfor
  s = SignalsTable1;
endfunction

function process(element)
  global SignalsTable1;
  if(strcmp(element.type,"AND"))
    SignalsTable1(element.output)=sp2AND(SignalsTable1{element.inputs(1)}, SignalsTable1{element.inputs(2)});
  elseif(strcmp(element.type,"NOT"))
    SignalsTable1(element.output)=spNOT(SignalsTable1{element.inputs(1)});
  else
    printf("wrong element \n");
  endif
endfunction

function s=sp2AND(input1sp, input2sp)
  s = input1sp*input2sp;
endfunction

function s=spNOT(input1sp)
  s = 1-input1sp;
endfunction

function esw(s)
  x = 2*s*(1-s);
  printf("%f \n",x);
endfunction