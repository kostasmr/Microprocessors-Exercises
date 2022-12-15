function s=stress_test_gen
  addpath ("/home/kwstasmr/Documents/UOI/Mikroep/Askisi3");
  signalsBefore={};
  signals={};
  Scores=[];
  parents=[];
  all_works={};
  L=2;
  N=30;
  m=0.05;
  G=100;
  for i=1:30
    %random workload
    Workload = random_workload(L);
    W.t1=Workload(1,:);
    W.t2=Workload(2,:);
    signalsBefore=circuit31(Workload(1,:));
    signals=circuit31(Workload(2,:));
    %count switches
    score=0;
    for l=1:size(signalsBefore,2)
      if(signalsBefore{l}!=signals{l})
        score=score+1;
      endif
    endfor
    Scores(i)=score;
    all_works{i}=W;
  endfor
  parents=gaSelectParents(Scores,all_works,N,L)
  C=randi(2);
  R=randi(2);
  %for j=1:30
    makeChildrens(parents(1),parents(2),C,R);
  %endfor
endfunction

function new=makeChildrens(parent1, parent2,C,R)
  new={};
  new_workload={};
  for i = 1:2
    if(C==1)
      N.t1=parent1.t1;
      N.t2=parent2.t2;
      new_workload=N;
      new{1}=new_workload;
      new{2}=parent2;
    elseif(C==2)
      N.t1=parent2.t1;
      N.t2=parent1.t2;
      new_workload=N;
      new{2}=new_workload;
      new{1}=parent1;
    endif
  endfor
endfunction 

function {parent1, parent2, score1,score2}=gaSelectParents(scores, population, N, L)
  best=-1; 
  sbest=-1;
  besti=-1;
  sbesti=-1; 
  for i=1:size(scores,2)
    if(scores(1,i)>best)
      sbest=best;
      best=scores(1,i);
      sbesti=besti;
      besti=i;
    elseif(scores(1,i)>=sbest)
      sbest=scores(1,i);
      sbesti=i;
    endif
  endfor
  parent1=gaGetWorkloadFromPopulation(N, L, population, besti);
  parent2=gaGetWorkloadFromPopulation(N, L, population, sbesti);
  score1=best;
  score2=sbest;
endfunction

function parent=gaGetWorkloadFromPopulation(N, L, population, best)
  parent={};
  for i=1:size(population,2)
    if(best==i)
      p.t1=population{i}.t1;
      p.t2=population{i}.t2;
      parent{1}=p;
    endif
  endfor
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
