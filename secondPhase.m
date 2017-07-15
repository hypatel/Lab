function m = secondPhase(dir_str)
  xfile1 = dir([dir_str,'/*_pc_1.mat']);
  M = NaN*ones(8,1);
  r_square = NaN*ones(8,1);
  x = 0;
  
  for ifile1 = length(xfile1):-1:1
    filename1 = [dir_str,xfile1(ifile1).name];
    fname = xfile1(ifile1).name(1:strfind(xfile1(ifile1).name, '_pc')-1);
    xfile = dir([filename1(1:strfind(filename1,'_pc')),'*.mat']);
    
    neps = length(xfile); %number of seconds in each study
    
    for ifile=1:neps
      m(end+1).name = fname;
      filename = [dir_str,xfile(ifile).name(1:strfind(xfile(ifile).name,'_pc_')+3),int2str(ifile),'.mat'];
      [state, M, r_square] = sampleTest(filename);
      m(end).minNum = ifile;
      m(end).state = state;
      m(end).m = M;
      m(end).r2 = r_square;
    end
   end
   
   x = writeData(m);
endfunction