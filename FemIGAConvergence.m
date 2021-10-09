carbon  = [3.703 5.529 6.166 6.649];
GFRP   = [3.069 4.159 4.382 4.468];
GEBIso  = [3.127 3.924 4.041 4.061];
GEB  = [2.709 3.238 3.590 3.919 3.977 ];
Kal4 = [4.11 4.11 4.11 4.11 ];
Kal5 = [6.719 6.719 6.719 6.719 ];
Kal6 = [4.409 4.409 4.409 4.409];

% Number of elements
Fem = [200 288 392 512 648];
IGA = [8 32 176 704 ];

figure(6)
hold on

plot(IGA,carbon,'-o')
plot(IGA,GFRP,'-o')
plot(IGA,Kal5,'-.')
plot(IGA,Kal6,'-.')
plot(IGA,GEBIso,'-o')
plot(IGA,Kal4,'-.')
plot(Fem,GEB,'-^')
DataplotIso = [IGA',Kal5',Kal4', Kal6', carbon', GFRP', GEBIso'];
DataplotFem = [Fem',GEB'];
ylim([0 8])
xlabel('Elements')
ylabel('SCFs')
title('Effect of mesh refinement in SCFs Convergence.')
legend({'IGA Carb/E','IGA GFRP','Kaltakci', 'Kaltakci','IGA Glass/Epox','Kaltakci','FEM Ref'},'Location','SouthEast')

H=gca;
H.LineWidth=1.5; 





