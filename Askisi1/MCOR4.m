function SwitchingActivity=MCOR4(N)


%% I1 I2 I3 I4 | O
%%  0  0  0  0 | 0 
%%  X  X  X  1 | 1 
%%  X  X  1  X | 1 
%%  X  1  X  X | 1 
%%  1  X  X  X | 1

Workload=[0 0 0 0; 1 1 1 1; 0 0 0 1; 1 1 1 1; 0 1 0 1];

MonteCarloSize=N;
for i = 1:MonteCarloSize
    Workload=[Workload; round(mod(rand(),2)), round(mod(rand(),2)), round(mod(rand(),2)), round(mod(rand(),2))];
end
vectorsNumber=size(Workload, 1);
gateInputsNumber=size(Workload, 2);
gateOutput=0||0||0||0;

switchesNumber=0;
for i = 1:vectorsNumber    
    NewGateOutput=Workload(i,1) ||  Workload(i,2) || Workload(i,3) || Workload(i,4);
    %NewGateOutput
    if (gateOutput==NewGateOutput)
        continue;
    else
        gateOutput=NewGateOutput;
    end
    
    switchesNumber=switchesNumber+1;
end
switchesNumber
vectorsNumber
SwitchingActivity=switchesNumber/vectorsNumber
    

endfunction