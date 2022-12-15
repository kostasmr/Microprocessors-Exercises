
function s=circuit3
  n=[10,100,4114,10000];
  for i = n
    printf("SwitchingActivities for N = %f : \n",i);
    Esw_e = MCAND2_e(i)
    Esw_c = MCNOT_c(i)
    Esw_d = MCAND2_d(i)
  endfor
endfunction

function SwitchingActivity=MCAND2_e(N)

gateOutput_and=0&0;
Workload=[0 0 0;0 1 0; 0 1 1; 1 1 0;1 1 1];

MonteCarloSize=N;
for i = 1:MonteCarloSize
    Workload=[Workload; round(mod(rand(),2)), round(mod(rand(),2)), round(mod(rand(),2))];
end
vectorsNumber=size(Workload, 1);
gateInputsNumber=size(Workload, 2);
switches_and=0;

%and1
for i = 1:vectorsNumber
    l=[];
    a = Workload(i,1);
    b = Workload(i,2);
    c = Workload(i,3);
    l = circuit(a,b,c);
    NewGateOutput=l(1);
    %NewGateOutput
    if (gateOutput_and==NewGateOutput)
        continue;
    else
        gateOutput_and=NewGateOutput;
    end
    
    switches_and=switches_and+1;
end
SwitchingActivity=switches_and/vectorsNumber;
   
endfunction

function SwitchingActivity=MCAND2_d(N)

gateOutput_and=0&0;
Workload=[0 0 0;0 1 0; 0 1 1; 1 1 0;1 1 1];

MonteCarloSize=N;
for i = 1:MonteCarloSize
    Workload=[Workload; round(mod(rand(),2)), round(mod(rand(),2)), round(mod(rand(),2))];
end
vectorsNumber=size(Workload, 1);
gateInputsNumber=size(Workload, 2);
switches_and=0;

%and1
for i = 1:vectorsNumber
    l=[];
    a = Workload(i,1);
    b = Workload(i,2);
    c = Workload(i,3);
    l = circuit(a,b,c);
    NewGateOutput=l(3);
    %NewGateOutput
    if (gateOutput_and==NewGateOutput)
        continue;
    else
        gateOutput_and=NewGateOutput;
    end
    
    switches_and=switches_and+1;
end
SwitchingActivity=switches_and/vectorsNumber;
   
endfunction

function SwitchingActivity=MCNOT_c(N)

gateOutput_not=0;
Workload=[0 0 0;0 1 0; 0 1 1; 1 1 0;1 1 1];

MonteCarloSize=N;
for i = 1:MonteCarloSize
    Workload=[Workload; round(mod(rand(),2)), round(mod(rand(),2)), round(mod(rand(),2))];
end
vectorsNumber=size(Workload, 1);
gateInputsNumber=size(Workload, 2);
switches_not=0;

%and1
for i = 1:vectorsNumber
    l=[];
    a = Workload(i,1);
    b = Workload(i,2);
    c = Workload(i,3);
    l = circuit(a,b,c);
    NewGateOutput=l(2);
    %NewGateOutput
    if (gateOutput_not==NewGateOutput)
        continue;
    else
        gateOutput_not=NewGateOutput;
    end
    
    switches_not=switches_not+1;
end
SwitchingActivity=switches_not/vectorsNumber;
   
endfunction