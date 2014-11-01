D0 = 100;
butterworth_filter(D0)
% butterworth_filter(D0*0.95)
% butterworth_filter(D0*1.05)

R = 58.5;
[RMSD, ratio] = circular_filter(R)
