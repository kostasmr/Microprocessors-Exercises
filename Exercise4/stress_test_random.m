function s=stress_test_random
  signalsBefore={};
  signals={};
  Scores=[];
  L=2;
  addpath ("/users/kwstas_mr/Documents/UOI/Mikroep/Askisi3");
  
  for i=1:20
    printf("individual%d\n",i);
    %random workload
    Workload = random_workload(L);
    %call circuit31 two times
    signalsBefore=helper(Workload(1,:));
    signals=helper(Workload(2,:));
    %count switches
    score=0;
    for l=1:size(signalsBefore,2)
      if(signalsBefore{l}!=signals{l})
        score=score+1;
      endif
    endfor
    Scores(i)=score;
  endfor
  x=[1:20];
  y=Scores;
  averageSwitches=mean(Scores);
  averageSwitches
  varianceSwitches=var(Scores);
  varianceSwitches
  plot(x,y);
  s=1;
endfunction

function s=random_workload(L)
  zero_one=[0,1];
  rand_work=[];
  Workload=[];
  for j=1:2
    for i=1:20
      Workload(j,i)=zero_one(randi(2));
    endfor
  endfor
  s=Workload;
endfunction
