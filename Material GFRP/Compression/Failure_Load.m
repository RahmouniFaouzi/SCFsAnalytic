

% Failure_Load for  Plate with and without Hole
% ============================================
clear , clc , close
[numbers1, strings1, raw1] = xlsread('Material_GFRP in comression');
[numbers2, strings2, raw2] = xlsread('Failure_GFRP_Without_Hole');

Failure_HR1 = numbers1(:,6)';
Failure_TH1 = numbers1(:,8)';
Failure_HV1 = numbers1(:,10)'; % Failure Data With Hole

Failure_HR2 = numbers2(:,2)';
Failure_TH2 = numbers2(:,3)';
Failure_HV2 = numbers2(:,4)';  % Failure Data Without Hole

Ang = 0:5:90;
figure(4)
hold on

plot(Ang,Failure_HR1,'-^')
plot(Ang,Failure_TH1,'-^')
plot(Ang,Failure_HV1,'-^')

plot(Ang,Failure_HR2,'-^')
plot(Ang,Failure_TH2,'-^')
plot(Ang,Failure_HV2,'-^')

xlabel('Angle (°)')
ylabel('Failure load')
title('Failure load for composite plates GFRP in Compression')
legend({'HR','TH','HV', 'HR','TH','HV'},'Location','SouthEast')







