% Failure_Load for  Plate with and without Hole
% ============================================
clear , clc , close all
[numbers1, strings1, raw1] = xlsread('Material_GFRP in Tension');
[numbers2, strings2, raw2] = xlsread('Failure_GFRP_Without_Hole');

[numbers3, ~, ~] = xlsread('GFRP in TN'); % RHT WITH HOLE
[numbers4, ~, ~] = xlsread('GFRP_Rht-Spline_Failure_data_TN Without Hole');% RHT WITHOUT HOLE


Failure_HR1 = numbers1(:,6)';
Failure_TH1 = numbers1(:,8)';
Failure_HV1 = numbers1(:,10)'; % Failure Data Kaltakci Eq With Hole

Failure_HR2 = numbers2(:,2)';
Failure_TH2 = numbers2(:,3)';
Failure_HV2 = numbers2(:,4)';  % Failure Data Kaltakci Eq Without Hole

Failure_HR3 = numbers3(:,4)';
Failure_TH3 = numbers3(:,5)';
Failure_HV3 = numbers3(:,6)';  % Failure Data Pht-Spline With Hole

Failure_HR4 = numbers4(:,4)';
Failure_TH4 = numbers4(:,5)';
Failure_HV4 = numbers4(:,6)';  % Failure Data Pht-Spline Without Hole

Ang = 0:5:90;
figure(4)
hold on
plot(Ang,Failure_HR1,'-^')
plot(Ang,Failure_HR2,'o')
plot(Ang,Failure_HR3,'-.')
plot(Ang,Failure_HR4,'-.')
legend({'HR1','HR2','HR3' ,'HR4'},'Location','NorthEast')
xlabel('Angle (°)')
ylim([0 1300])
ylabel('Failure load (Mpa)')
title('Failure load Hashin-Rotem Glass_Epoxy in Tension')

H = gca;
H.LineWidth = 1.5; 
set(gcf,'position',[10,10,400,350])

figure(5)
hold on
plot(Ang,Failure_TH1,'-^')
plot(Ang,Failure_TH2,'o')
plot(Ang,Failure_TH3,'-.')
plot(Ang,Failure_TH4,'-.')
legend({'TH1','TH2','TH3','TH4'},'Location','NorthEast')
xlabel('Angle (°)')
ylim([0 1300])
ylabel('Failure load (Mpa)')
title('Failure load Tsai-Hill Glass_Epoxy in Tension')

H = gca;
H.LineWidth = 1.5; 
set(gcf,'position',[10,10,400,350])

figure(6)
hold on
plot(Ang,Failure_HV1,'-^')
plot(Ang,Failure_HV2,'o')
plot(Ang,Failure_HV3,'-.')
plot(Ang,Failure_HV4,'-.')
legend({'HV1','HV2','HV3','HV4'},'Location','NorthEast')
xlabel('Angle (°)')
ylim([0 1300])
ylabel('Failure load (Mpa)')
title('Failure load Hencky-Von Mises Glass_Epoxy in Tension')

H = gca;
H.LineWidth = 1.5; 
set(gcf,'position',[10,10,400,350])