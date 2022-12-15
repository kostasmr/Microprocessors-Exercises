

function s=signalprobs(varargin)
  switch nargin
    case 2
      input1sp = varargin{1};
      input2sp = varargin{2};
      sp2AND(input1sp, input2sp)
      sp2OR(input1sp, input2sp)
      sp2XOR(input1sp, input2sp)
      sp2NAND(input1sp, input2sp)
      sp2NOR(input1sp, input2sp)
     case 3
      input1sp = varargin{1};
      input2sp = varargin{2};
      input3sp = varargin{3};
      sp3AND(input1sp, input2sp, input3sp)
      sp3OR(input1sp, input2sp, input3sp)
      sp3XOR(input1sp, input2sp, input3sp)
      sp3NAND(input1sp, input2sp, input3sp)
      sp3NOR(input1sp, input2sp, input3sp)
     otherwise
      inputs=[varargin{:}];
      spAND(inputs)
      spOR(inputs)
      spXOR(inputs)
      spNAND(inputs)
      spNOR(inputs)
  endswitch
endfunction


%

% 2-input AND gate truth table
% 0 0:0
% 0 1:0
% 1 0:0
% 1 1:1
%% signal probability calculator for a 2-input AND gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2AND(input1sp, input2sp)
  printf("AND Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = input1sp*input2sp;
  esw(s);
endfunction

% 2-input OR gate truth table
% 0 0:0
% 0 1:1
% 1 0:1
% 1 1:1
%% signal probability calculator for a 2-input OR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2OR(input1sp, input2sp)
  printf("OR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = 1-(1-input1sp)*(1-input2sp);
  esw(s);
endfunction


% 2-input XOR gate truth table
% 0 0:0
% 0 1:1
% 1 0:1
% 1 1:0
%% signal probability calculator for a 2-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2XOR(input1sp, input2sp)
  printf("XOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = input1sp+input2sp-2*(input1sp*input2sp);
  esw(s);
endfunction


% 2-input NAND gate truth table
% 0 0:1
% 0 1:1
% 1 0:1
% 1 1:0
%% signal probability calculator for a 2-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2NAND(input1sp, input2sp)
  printf("NAND Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = 1 - (input1sp*input2sp);
  esw(s);
endfunction



% 2-input NOR gate truth table
% 0 0:1
% 0 1:0
% 1 0:0
% 1 1:0
%% signal probability calculator for a 2-input NOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2NOR(input1sp, input2sp)
  printf("NOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = 1 - (1-(1-input1sp)*(1-input2sp));
  esw(s);
endfunction






%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1.3 b


function s=sp3AND(input1sp,input2sp,input3sp)
  printf("AND Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = input1sp*input2sp*input3sp;
  esw(s);
endfunction

function s=sp3OR(input1sp, input2sp,input3sp)
  printf("OR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = (1-input1sp)*(1-input2sp)*input3sp+(1-input1sp)*input2sp*(1-input3sp)+(1-input1sp)*input2sp*input3sp+input1sp*(1-input2sp)*(1-input3sp)+input1sp*(1-input2sp)*input3sp+input1sp*input2sp*(1-input3sp)+input1sp*input2sp*input3sp;
  esw(s);
endfunction

function s=sp3XOR(input1sp, input2sp,input3sp)
  printf("XOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = input1sp+input2sp+input3sp-2*(input1sp*input2sp)-2*(input1sp*input3sp)-2*(input2sp*input3sp)+4*(input1sp*input2sp*input3sp);
  esw(s);
endfunction

function s=sp3NAND(input1sp,input2sp,input3sp)
  printf("NAND Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = 1-(input1sp*input2sp*input3sp);
  esw(s);
endfunction

function s=sp3NOR(input1sp, input2sp,input3sp)
  printf("NOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = 1-(s = (1-input1sp)*(1-input2sp)*input3sp+(1-input1sp)*input2sp*(1-input3sp)+(1-input1sp)*input2sp*input3sp+input1sp*(1-input2sp)*(1-input3sp)+input1sp*(1-input2sp)*input3sp+input1sp*input2sp*(1-input3sp)+input1sp*input2sp*input3sp);
  esw(s);
endfunction


%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
% 1.3 g


function s=spAND(inputs)
  printf("AND Gate for input probabilities : ")
  fprintf("%f \t",inputs)
  printf("\n")
  y = 1;
  for i = inputs
    y = y*i;
  endfor
  s = y;
  esw(s);
endfunction

function s=spOR(inputs)
  printf("OR Gate for input probabilities : ")
  fprintf("%f \t",inputs)
  printf("\n")
  y = 1;
  for i = inputs
    y = y*(1-i);
  endfor
  s=1-y;
  esw(s);
endfunction

function s=spXOR(inputs)
  printf("XOR Gate for input probabilities : ")
  fprintf("%f \t",inputs)
  printf("\n")
  y=1;
  for i = inputs
    y = y + i -2*(y*i);
  endfor
  s = y;
  esw(s);
endfunction

function s=spNAND(inputs)
  printf("NAND Gate for input probabilities : ")
  fprintf("%f \t",inputs)
  printf("\n")
  y = 1;
  for i = inputs
    y = y*i;
  endfor
  s = 1 - y;
  esw(s);
endfunction

function s=spNOR(inputs)
  printf("NOR Gate for input probabilities : ")
  fprintf("%f \t",inputs)
  printf("\n")
  y = 1;
  for i = inputs
    y = y*(1-i);
  endfor
  s = 1-(1-y);
  esw(s);
endfunction

%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%
%1.3 d

function esw(s)
  x = 2*s*(1-s);
  printf("Switcginh activity: %f \n",x)
endfunction