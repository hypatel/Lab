function x = writeData(m)
  x = 0;
  fwrtb = 'outfile.out';
  fiwb = fopen(fwrtb,'w');
  if(fiwb == -1); disp(['cant open ', fwrtb,'!']); return; end
  
  %print header
  fprintf(fiwb,'%s', 'File ', '"Minute Number" ','State ', 'LFP_RFP_M ', 'LF_RF_M ', 'LC_RC_M ', 'LT_RT_M ','LP_RP_M ','LO_RO_M ','LO_LFP_M ', 'RO_RFP_M ',...
          'LFP_RFP_R2 ', 'LF_RF_R2 ', 'LC_RC_R2 ', 'LT_RT_R2 ', 'LP_RP_R2 ', 'LO_RO_R2 ', 'LO_LFP_R2 ', 'RO_RFP_R2 ');
  fprintf(fiwb,'\r\n');
  
  for i=1:length(m)
    fprintf(fiwb, '%s', m(i).name, ' ');
    fprintf(fiwb, '%i',m(i).minNum);
    fprintf(fiwb, '%s', ' ');
    fprintf(fiwb, '%s', m(i).state);
    fprintf(fiwb, '%s', ' ');
    for j=1:8
      fprintf(fiwb, '%4.3f',m(i).m(j));
      fprintf(fiwb, '%s', ' ');
    end
    for j=1:8
      fprintf(fiwb, '%4.3f', m(i).r2(j));
      if(j!=8)
        fprintf(fiwb, '%s', ' ');
      end
    end
    fprintf(fiwb,'\r\n');
  end
         
  
  %close
  fclose(fiwb);
  x = 1;
  
endfunction