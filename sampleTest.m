function [state, m, r_square] = sampleTest(file)
  %initialize return values to 0
  state = 0;
  m = NaN*ones(8,1);
  r_square = NaN*ones(8,1);
  %dirName = 'C:\Octave\Hardik2subs\'; %directory where data is stored
  %file = [dirName,file];
  
  %load file
  data = load(file);
  state = data.state;
  fr = (data.fr)';
  
  data.cohsr(data.cohsr == complex(-0.2,0)) = NaN;
  
  %calculate phase array
  phase = angle(data.cohsr);
  
  %calculate mean of phases
  lf_rf_phase = NaN*ones(fr,1);
  lp_rp_phase = NaN*ones(fr,1);
  
  for f=1:size(fr)
    lf_rf_phase(f,1) = MyCircMean([phase(f,4,3) phase(f,11,4) phase(f,12,11) phase(f,12,13)]');
    lp_rp_phase(f,1) = MyCircMean([phase(f,8,7) phase(f,15,8) phase(f,16,7) phase(f,16,15)]');
  end
  
  %linear regression polyfit with first output being the slope
  m(1) = polyfit(fr, phase(:,2,1),1)(1); %lfp_rfp
  m(2) = polyfit(fr, lf_rf_phase,1)(1); %lf_rf
  m(3) = polyfit(fr, phase(:,6,5),1)(1); %lc_rc
  m(4) = polyfit(fr, phase(:,14,13),1)(1); %lt_rt
  m(5) = polyfit(fr, lp_rp_phase,1)(1); %lp_rp
  m(6) = polyfit(fr, phase(:,10,9),1)(1); %lo_ro
  m(7) = polyfit(fr, phase(:,9,1),1)(1); %lp_lfp
  m(8) = polyfit(fr, phase(:,10,2),1)(1); %ro_rfp
  
  %correlation coefficient
  r_square(1) = corr(fr, phase(:,2,1))^2; %lfp_rfp
  r_square(2) = corr(fr, lf_rf_phase)^2; %lf_rf
  r_square(3) = corr(fr, phase(:,6,5))^2; %lc_rc
  r_square(4) = corr(fr, phase(:,14,13))^2; %lt_rt
  r_square(5) = corr(fr, lp_rp_phase)^2; %lp_rp
  r_square(6) = corr(fr, phase(:,10,9))^2; %lo_ro
  r_square(7) = corr(fr, phase(:,9,1))^2; %lp_lfp
  r_square(8) = corr(fr, phase(:,10,2))^2; %ro_rfp
  
 endfunction