
function s=circuit3(varargin)
  user_inputs=[varargin{:}];
  Alphabet=["a":"z"];
  clear SignalsTable2;
  global SignalsTable2={};
  ElementsTable={};
  ElementsTableSorted={};
  signals={};
  pos=1;
  f = fopen("not_sorted.txt","r");
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
  
  %sort the ElementsTable
  counter2=1;
  while(size(ElementsTableSorted,2)!=size(ElementsTable,2))
    for i = 1:size(ElementsTable,2)
      for j = 1:size(top_inputs,2)
        if(ElementsTable{i}.inputs(1)==top_inputs{j})
          if(ElementsTable{i}.check==0)
            ElementsTable{i}.check=1;
            ElementsTableSorted{counter2}=ElementsTable{i};
            top_inputs(end+1)=ElementsTable{i}.output;
            counter2 = counter2 +1;
          endif
        endif
      endfor
    endfor
  endwhile
  ElementsTable
  ElementsTableSorted
  
  %call process
  for i=1:size(ElementsTableSorted,2)
    process(ElementsTableSorted{i});
    printf("Switching activity for Element(pos %d) %s is : ",i,ElementsTableSorted{i}.type);
    esw(SignalsTable2{ElementsTableSorted{i}.output});
  endfor
  
  for i=1:size(signals,2)
    printf("%s=%d\t",signals{i}.name,signals{i}.pos);
  endfor
  printf("\n");
  s = SignalsTable2;
  fclose(f);  
endfunction


function process(element)
  global SignalsTable2;
  signal=[];
  for i = 1:size(element.inputs,2)
    signal(end+1)=SignalsTable2{element.inputs(i)};
  endfor
  SignalsTable2(element.output)=spByType(element.type,signal);
endfunction

function s=spByType(type,varargin)
  if(strcmp(type,"AND"))
    s=spAND(varargin{:});
  elseif(strcmp(type,"NOT"))
    s=spNOT(varargin{:});
  elseif(strcmp(type,"OR"))
    s=spOR(varargin{:});
  elseif(strcmp(type,"XOR"))
    s=spXOR(varargin{:});
  elseif(strcmp(type,"NAND"))
    s=spNAND(varargin{:});
  elseif(strcmp(type,"NOR"))
    s=spNOR(varargin{:}); 
  elseif(strcmp(type,"XNOR"))
    s=1-(spXOR(varargin{:})); 
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

function esw(s)
  x = 2*s*(1-s);
  printf("%f \n",x);
endfunction