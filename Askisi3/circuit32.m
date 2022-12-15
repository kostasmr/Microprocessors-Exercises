function s=circuit32(varargin)
  user_inputs=[varargin{:}];
  Alphabet=["a":"z"];
  SignalsTable2={};
  global ElementsTable={};
  ElementsTableSorted={};
  signals={};
  pos=1;
  f = fopen("/home/kwstasmr/Documents/UOI/Mikroep/Askisi4/example41.txt","r");
  all_inputs={};
  all_outputs={};
  all_types={};
  top_inputs={};
  counter=1;
  top=0;
  while(! feof(f))
    x="";
    type="";
    output="";
    inputs={};
    x = fgets(f,1);
    %top_inputs
    if(strcmp(x,"t") || strcmp(x,"T"))
      while(strcmp(x," ")==0) 
        x = fgets(f,1);
      endwhile
      while(ismember(x,Alphabet)==0)
        x = fgets(f,1);
      endwhile
      var="";
      while(strcmp(x,"\n")==0 && x!=-1)
        if(strcmp(x," ")==0 && strcmp(x,"\n")==0 && x!=-1) 
          var=strcat(var,x);
        else
          top_inputs(end+1)=var;
          var="";
        endif
        x = fgets(f,1);
        if(strcmp(x,"\n")==1)
          top_inputs(end+1)=var;
          var="";
        endif     
      endwhile
      top=1;
      x = fgets(f,1);
    endif
    while(strcmp(x," ")==0) 
     type = strcat(type, x);
     x = fgets(f,1);
    endwhile
    all_types(end+1)=type;
    E.type=type;
    
    %output
    output="";
    x =fgets(f,1);
    while(strcmp(x," ")==0)
      output=strcat(output,x);
      x=fgets(f,1);
    endwhile
    all_outputs(end+1)=output;

    x = fgets(f,1);
    %inputs
    temp=[];
    while(strcmp(x,"\n")==0 && x!=-1)
      if(strcmp(x," ")==0 && strcmp(x,"\n")==0 && x!=-1)
        var=strcat(var,x);
      else
        inputs(end+1)=var;
        all_inputs(end+1)=var;
        %add input to signals  
        if(size(signals,2)==0)
          S.name=var;
          S.pos=pos;
          temp(end+1) =pos;
          signals(end+1)=S;
          pos = pos + 1;
          var="";
          x = fgets(f,1);
          continue;
        endif
        same=0;
        for (i = 1:size(signals,2))
          if (strcmp(var,signals{i}.name))
            same=1;
            temp(end+1) = signals{i}.pos;
            var="";
          endif
        endfor
        if(same==0)
          S.name=var;
          S.pos=pos;
          temp(end+1) =pos;
          signals(end+1)=S;
          pos = pos + 1;
          var="";
        endif
      endif
      x = fgets(f,1);
      if(strcmp(x,"\n")==1 || x==-1)
        inputs(end+1)=var;
        all_inputs(end+1)=var;
        %add input to signals  
        if(size(signals,2)==0)
          S.name=var;
          S.pos=pos;
          temp(end+1) =pos;
          signals(end+1)=S;
          pos = pos + 1;
          var="";
          continue;
        endif
        same=0;
        for (i = 1:size(signals,2))
          if (strcmp(var,signals{i}.name))
            same=1;
            temp(end+1) = signals{i}.pos;
            var="";
          endif
        endfor
        if(same==0)
          S.name=var;
          S.pos=pos;
          temp(end+1) =pos;
          signals(end+1)=S;
          pos = pos + 1;
          var="";
        endif
      endif
    endwhile
    E.inputs =temp;
    
    same=0;
    for i = 1:size(signals,2)
      if(strcmp(output,signals{i}.name))
        same=1;
        E.output = [signals{i}.pos];
      endif
    endfor
    if(same==0)
      S.name=output;
      S.pos=pos;
      E.output = [pos];
      signals(end+1)=S;
      pos = pos + 1;
      same=0;
    endif
    E.check=0;
    ElementsTable{counter}=E;
    counter = counter + 1;
  endwhile

  %top_inputs
  if(top==0)
    for i=1:size(all_inputs,2)
      check=0;
      for j=1:size(all_outputs,2)
        if(strcmp(all_inputs{i},all_outputs{j}))
          check=1;
        endif
      endfor
      if(check==0)
        top_inputs(end+1)=all_inputs{i};
      endif
    endfor
  endif
  
  top_pos=0;
  for i =1:size(top_inputs,2)
    for j = 1:size(signals,2)
      if (strcmp(top_inputs{i},signals{j}.name))
        top_pos=signals{j}.pos;
      endif
    endfor
    SignalsTable2{top_pos}=user_inputs(i);
  endfor
  
  for i = 1:size(top_inputs,2)
    for j = 1:size(signals,2)
      if(strcmp(top_inputs{i},signals{j}.name))
        top_inputs{i}=signals{j}.pos;
      endif
    endfor
  endfor

  %call process
  esw_count=0;
  for k=1:size(ElementsTable,2)
    %process(ElementsTable{k});
    %printf("Switching activity for Element(pos %d) %s is : ",i,ElementsTableSorted{i}.type);
    signal=[];
    inp=0;

    for l = 1:size(ElementsTable{k}.inputs,2)
      inp=ElementsTable{k}.inputs(l);
      signal(end+1)=SignalsTable2{inp};
    endfor
    SignalsTable2(ElementsTable{k}.output)=spByType(ElementsTable{k}.type,signal);
    esw_count=esw_count+esw(SignalsTable2{ElementsTable{k}.output});
  endfor
  
  s =esw_count;
  fclose(f);  
endfunction

function sort()
  global ElementsTable
  global ElementsTableSorted;
  global top_inputs;
  global counter2;
  all_check=0;
  size_inp=0;
  
  for i = 1:size(ElementsTable,2)
    size_inp=length(ElementsTable{i}.inputs);
    for k=1:size_inp
      for j=1:size(top_inputs,2)
        if(ElementsTable{i}.inputs(k)==top_inputs{j})
          all_check =all_check+1;
        elseif(ElementsTable{i}.check==0 && all_check==size_inp)
          ElementsTable{i}.check=1;
          ElementsTableSorted{counter2}=ElementsTable{i};
          top_inputs(end+1)=ElementsTable{i}.output;
          counter2 = counter2 +1;
          all_check=0;
          size_inp=0;
        else
          continue;
        endif
      endfor
    endfor
  endfor
endfunction

function process(element)
  global SignalsTable2;
  signal=[];
  inp=0;

  for l = 1:size(element.inputs,2)
    inp=element.inputs(l);
    signal(end+1)=SignalsTable2{inp};
  endfor
  SignalsTable2(element.output)=spByType(element.type,signal);
endfunction

function s=spByType(type,varargin)
  sig=[varargin{:}];
  if(strcmp(type,"AND"))
    s=spAND(sig);
  elseif(strcmp(type,"NOT"))
    s=spNOT(sig);
  elseif(strcmp(type,"OR"))
    s=spOR(sig);
  elseif(strcmp(type,"XOR"))
    s=spXOR(sig);
  elseif(strcmp(type,"NAND"))
    s=spNAND(sig);
  elseif(strcmp(type,"NOR"))
    s=spNOR(sig); 
  elseif(strcmp(type,"XNOR"))
    s=1-(spXOR(sig)); 
  else
    printf("unsupported");
    type
  endif
endfunction

function s=spAND(inputs)
  y = 1;
  for i = inputs
    y = y*i;
  endfor
  s = y;
endfunction

function s=spOR(inputs)
  y = 1;
  for i = inputs
    y = y*(1-i);
  endfor
  s=1-y;
endfunction

function s=spXOR(inputs)
  y=1;
  for i = inputs
    y = y + i -2*(y*i);
  endfor
  s = y;
endfunction

function s=spNAND(inputs)
  y = 1;
  for i = inputs
    y = y*i;
  endfor
  s = 1 - y;
endfunction

function s=spNOR(inputs)
  y = 1;
  for i = inputs
    y = y*(1-i);
  endfor
  s = 1-(1-y);
endfunction

function s=spNOT(input1sp)
  s = 1-input1sp;
endfunction

function x=esw(s)
  x = 2*s*(1-s);
  %printf("%f \n",x);
endfunction